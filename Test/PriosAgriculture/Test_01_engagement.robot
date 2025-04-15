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
    01_AM_Vente_creationOL.When L'utilisateur clique sur "PRIOS A-M Ventes"
    01_Engagement_vente.When L'utilisateur choisit "Engagements" dans la deuxième colonne
    01_Engagement_vente.When L'utilisateur sélectionne "Engagements" dans la troisième colonne
    01_Engagement_vente.Then L'utilisateur est redirigé vers un formulaire contenant une liste d'engagements vide
    #01_Engagement_vente.When L'utilisateur effectue une recherche avec les critères suivants :Date d'engagement à partir de, Date du jour - "3" moi,Soldés, Non soldés
    01_Engagement_vente.When L'utilisateur clique sur le bouton '+' ou clique droit dans la liste et sélectionne "Nouveau"
    01_Engagement_vente.Then L'utilisateur est redirigé vers l'entête engagement avec le formulaire
    01_Engagement_vente.When L'utilisateur sélectionne type engagement dans la liste déroulante depuis la section 'Informations générales puis Classification'
    01_Engagement_vente.Then Le type d'engagement est affiché dans la liste déroulante
    01_Engagement_vente.When L'utilisateur saisit dans le champ "Engagé par" depuis la section 'Informations générales puis Compléments'
    01_Engagement_vente.Then La valeur "ABBAYE61" est affichée dans le champ "Engagé par"
    01_Engagement_vente.When L'utilisateur saisit la date du jour dans le champ "Date d'engagement" depuis la section 'Informations générales puis Compléments'
    01_Engagement_vente.Then La date du jour est affichée dans le champ "Date d'engagement"
    01_Engagement_vente.When L'utilisateur clique sur le bouton "Enregistrer"
    01_Engagement_vente.Then Un engagement est créé avec les détails
    01_Engagement_vente.When L'utilisateur clique sur le bouton loupe à côté du champ 'Produit' dans la section 'Informations générales'
    01_Engagement_vente.Then La liste de produits est affichée
    01_Engagement_vente.When L'utilisateur saisit le code du produit dans le champ 'Produit' et clique sur la loupe
    01_Engagement_vente.Then Le produit correspondant est affiché dans la liste
    01_Engagement_vente.When L'utilisateur double-clique sur le produit ou sélectionne la ligne de produit et clique sur 'Sélectionner'
    01_Engagement_vente.Then Le détail de l'engagement est affiché avec le code de produit renseigné
    01_Engagement_vente.When L'utilisateur saisit la quantité engagée T dans le champ 'Engagée'
    01_Engagement_vente.Then La quantité engagée est affichée dans le champ
    01_Engagement_vente.When L'utilisateur navigue vers l'onglet 'Livraison'
    01_Engagement_vente.Then Le formulaire de livraison est affiché avec les détails partiellement remplis
    01_Engagement_vente.When L'utilisateur saisit la date de période de livraison avec le début de mois et la fin de livraison = dernier jour du mois suivant
    #01_Engagement_vente.Then Les dates sont affichées dans les champs correspondants
    01_Engagement_vente.When L'utilisateur navigue vers l'onglet 'Tarification'
    01_Engagement_vente.Then Le formulaire de tarification est affiché avec les détails partiellement remplis
    01_Engagement_vente.When L'utilisateur saisit le prix brut unitaire forcé
    01_Engagement_vente.Then Le prix brut unitaire forcé est affiché dans le champ
    01_Engagement_vente.When L'utilisateur sélectionne le niveau de prix d'application dans la liste déroulante
    01_Engagement_vente.Then Le niveau de prix d'application est sélectionné
    01_Engagement_vente.When L'utilisateur coche la case "Forcé"
    01_Engagement_vente.When L'utilisateur sélectionne le motif de forçage du prix dans la liste déroulante
    01_Engagement_vente.Then Le motif de forçage du prix est sélectionné
    01_Engagement_vente.When L'utilisateur clique sur le bouton "Enregistrer1"
    01_Engagement_vente.Then La liste des lignes de l'engagement est affichée avec les détails mis à jour
    01_Engagement_vente.When L'utilisateur ferme la fenêtre de détail de l'engagement
    01_Engagement_vente.Then L'engagement est affiché dans la liste des engagements en tête
    01_Engagement_vente.When L'utilisateur revient à la liste des engagements et effectue une recherche en utilisant la date et le numéro de l'engagement
    01_Engagement_vente.And l'utilisateur bascule vers l'onglet détails engagement
    01_Engagement_vente.Then La liste des détails de l'engagement est correctement mise à jour












