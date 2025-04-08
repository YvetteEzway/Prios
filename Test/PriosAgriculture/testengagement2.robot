*** Settings ***
Library    SeleniumLibrary    run_on_failure=Capture Page Screenshot
Library    OperatingSystem
Library    Collections
Resource    Authentification/login_page.robot
Resource    01.PRIOS_A-M_Ventes/01_AM_Vente_creationOL.robot
Resource    01.PRIOS_A-M_Ventes/02_AM_Vente_Transformation_OL_en_BL.robot
Resource    01.PRIOS_A-M_Ventes/03_AM_Vente_Modification_des_prix_des_produits__BL_avant_facturation.robot
Resource    02.A-M Ventes_Eng_01/01_Engagement_vente.robot
Resource    02.A-M Ventes_Eng_01/02_Création_OL_sur_Engagement.robot

*** Variables ***
${URL}          https://portail-0015.cloud-prios.fr/
${USERNAME}     prios.qa1@prios.fr
${PASSWORD}     Ezw@171M

*** Keywords ***
Open Browser With Options
    [Arguments]    ${url}
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --no-first-run
    Call Method    ${options}    add_argument    --no-default-browser-check
    Call Method    ${options}    add_argument    --disable-default-apps
    Call Method    ${options}    add_argument    --disable-popup-blocking
    ${prefs} =    Evaluate    {'profile.default_content_setting_values.geolocation': 1, 'profile.default_content_setting_values.notifications': 2}
    Call Method    ${options}    add_experimental_option    prefs    ${prefs}
    Create Webdriver    Chrome    options=${options}
    Go To    ${url}
    Maximize Browser Window
Maintenir Niveau Zoom Navigateur
    Execute JavaScript    document.querySelector('html').style.transform = 'scale(0.9)'; document.querySelector('html').style.transformOrigin = '0 0';

*** Test Cases ***
Login And Navigate to engagement
    [Documentation]    Connectez-vous et naviguez vers la transformation OL en BL
    Open Browser With Options    ${URL}
    login_page.Input Username    ${USERNAME}
    Capture Page Screenshot    user_name.png
    login_page.Click Login Button
    login_page.Input Password    ${PASSWORD}
    Capture Page Screenshot    password.png
    login_page.Click Login Button
    01_AM_Vente_creationOL.Given L'utilisateur se trouve sur la page "Plateformes métier"
    01_AM_Vente_creationOL.When L'utilisateur sélectionne l'option "PRIOS Agriculture" dans la section "Plateformes métier"
    01_AM_Vente_creationOL.Then Il est redirigé vers une nouvelle page avec les menus de navigation
    01_AM_Vente_creationOL.Then Les menus de navigation affichent les options suivantes dans les premières "8" options :
    #01_AM_Vente_creationOL.When L'utilisateur clique sur "PRIOS A-M Ventes"
    #02_Création_OL_sur_Engagement.When L'utilisateur sélectionne "Ordres de livraison" dans la deuxième colonne
    02_Création_OL_sur_Engagement.When L'utilisateur sélectionne Ordres de livraison dans la troisième colonne
    02_Création_OL_sur_Engagement.Then il est redirigé vers un formulaire affichant une liste vide d'ordres de livraison
    02_Création_OL_sur_Engagement.When l'utilisateur fait un clic droit sur la liste
    02_Création_OL_sur_Engagement.Then l'utilisateur voit une liste de choix avec:
    02_Création_OL_sur_Engagement.When l'utilisateur sélectionne "Nouveau..."
    02_Création_OL_sur_Engagement.Then l'utilisateur est redirigé vers un formulaire pour ajouter un nouvel "Ordre de livraison"
    02_Création_OL_sur_Engagement.And si une commande existe déjà, les informations sont récupérées
    02_Création_OL_sur_Engagement.L'utilisateur sélectionne un type d'ordre de livraison : "AB_OL Standard (AB1)"
    02_Création_OL_sur_Engagement.Then "AB_OL Standard (AB1)" est affiché dans le champ
    02_Création_OL_sur_Engagement.Then "AB_Site de L Etrat (AB1)" est affiché dans le champ
    02_Création_OL_sur_Engagement.And l'utilisateur saisit le 'Tiers donneur d'ordre' dans le champ
    02_Création_OL_sur_Engagement.And le contenu du champ "Date de livraison souhaitée est automatiquement renseignée avec la date actuelle +2 jours ouvrés
    02_Création_OL_sur_Engagement.When L'utilisateur saisit la date du jour dans le champ date de départ
    02_Création_OL_sur_Engagement.And l'utilisateur click sur le bouton enregisterer
    02_Création_OL_sur_Engagement.Given l'utilisateur est sur le détail de l'ordre de livraison
    02_Création_OL_sur_Engagement.When l'utilisateur clique sur le bouton + pour ajouter un produit
    02_Création_OL_sur_Engagement.When il entre les 3 premiers caractères du code produit "ABBAYE61"
    02_Création_OL_sur_Engagement.Then une fenêtre de choix de produits apparaît
    02_Création_OL_sur_Engagement.When il choisit le produit "IMSFB1"
    02_Création_OL_sur_Engagement.Then les champs sont pré-remplis avec les informations du produit
    02_Création_OL_sur_Engagement.Given l'utilisateur saisit la quantité à livrer dans le champ Quantité
    02_Création_OL_sur_Engagement.Then l'utilisateur verifie les informations dans la section Livraison
    02_Création_OL_sur_Engagement.Then l'utilisateur verifie les informations dans la section Facturation
    02_Création_OL_sur_Engagement.Then l'utilisateur verifie les informations dans la section 'Société et établissements commerciaux'
    02_Création_OL_sur_Engagement.And l'utilisateur clique sur le bouton '€ ' depuis le menu vertical à droite
    02_Création_OL_sur_Engagement.Then ouverture d'une fenetre pour Infos Tarification / OL [M] - Sté PRIOS - Etablissement CARQUEFOU avec le prix brute
    02_Création_OL_sur_Engagement.Fermer la fenêtre pour info tarification
    02_Création_OL_sur_Engagement.Cliquer sur le bouton enregistrer
    02_Création_OL_sur_Engagement.When l'utilisateur clique sur le bouton Fermer pour fermer le formulaire d'ajout produit
    02_Création_OL_sur_Engagement.Then le formulaire d'ajout de produit est fermé et les détails de l'ordre de livraison s'affichent au premier plan
    02_Création_OL_sur_Engagement.When l'utilisateur clique sur le bouton Valider
    02_Création_OL_sur_Engagement.Then Un document PDF d'un OL contenant les informations pour l'ordre de livraison s'ouvre dans un nouvel onglet avec le statut validé
    02_Création_OL_sur_Engagement.And l'utilisateur la fenetre contenant une liste des ordres de livraison et il est rediger vers le menu principal
    02_Création_OL_sur_Engagement.When L'utilisateur choisit "Engagements" pour le OL créer dans la deuxième colonne
    02_Création_OL_sur_Engagement.When L'utilisateur sélectionne "Engagements" pour le OL dans la troisième colonne
    02_Création_OL_sur_Engagement.Then L'utilisateur est redirigé vers un formulaire contenant une liste d'engagements vide avec bouton ajout
    02_Création_OL_sur_Engagement.When l'utilisateur saisi le numéro d'engagement précedemment créer dans le champ Numéro d'engagement
    02_Création_OL_sur_Engagement.And l'utilisateur clique sur le bouton loupe
    02_Création_OL_sur_Engagement.When la ligne d'engagement s'affiche dans la liste des engagements
    02_Création_OL_sur_Engagement.Then l'utilisateur navigue sur l'onglet "Détails"
    02_Création_OL_sur_Engagement.Then la ligne pou les détails de l'engagement s'affiche
    02_Création_OL_sur_Engagement.And l'utilisateur verifie la colonne reste à livrer sur la ligne
