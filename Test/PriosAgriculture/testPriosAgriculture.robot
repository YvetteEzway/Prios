*** Settings ***
Library    SeleniumLibrary    run_on_failure=Capture Page Screenshot
Library    Collections
Library    OperatingSystem
Library    Process
Library    String
Library    BuiltIn

Resource    Authentification/login_page.robot
Resource    01.PRIOS_A-M_Ventes/01_AM_Vente_creationOL.robot
Resource    01.PRIOS_A-M_Ventes/02_AM_Vente_Transformation_OL_en_BL.robot
Resource    01.PRIOS_A-M_Ventes/03_AM_Vente_Modification_des_prix_des_produits__BL_avant_facturation.robot
Resource    01.PRIOS_A-M_Ventes/03_AM_Vente_Modification_des_prix_des_produits__BL_avant_facturation.robot
Resource    01.PRIOS_A-M_Ventes/04_AM_Vente_Facturation_dun_BL.robot


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

*** Test Cases ***
Login And Navigate To Ordres De Livraison
    [Documentation]    Connectez-vous et naviguez vers les ordres de livraison
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
    01_AM_Vente_creationOL.Then Les menus de navigation affichent les options suivantes :
    01_AM_Vente_creationOL.When L'utilisateur clique sur "PRIOS A-M Ventes"
    01_AM_Vente_creationOL.Then L'affichage de la page présente les fonctions suivantes dans la première partie de la deuxième colonne :
    01_AM_Vente_creationOL.Then L'affichage de la page présente les fonctions suivantes dans la seconde partie de la deuxième colonne :
    01_AM_Vente_creationOL.When L'utilisateur sélectionne "Ordres de livraison" dans la deuxième colonne
    01_AM_Vente_creationOL.Then Les fonctions suivantes apparaissent dans la première partie de la troisième colonne :
    01_AM_Vente_creationOL.Then Les fonctions suivantes apparaissent dans la seconde partie de la troisième colonne :
    01_AM_Vente_creationOL.When L'utilisateur sélectionne Ordres de livraison dans la troisième colonne
    01_AM_Vente_creationOL.Then L'utilisateur est redirigé vers un formulaire contenant une liste vide d'ordres de livraison
    01_AM_Vente_creationOL.When L'utilisateur clique sur le bouton "+"
    01_AM_Vente_creationOL.Then L'utilisateur est redirigé vers un formulaire pour ajouter un nouvel ordre de livraison
    01_AM_Vente_creationOL.And Si une commande a déjà été créée, alors le formulaire récupère les informations précédemment saisies pour le Preneur d'ordre
    01_AM_Vente_creationOL.L'utilisateur sélectionne un type d'ordre de livraison : "OL Standard (STD)"
    01_AM_Vente_creationOL.Then "OL Standard (STD)" est affiché dans le champ
    01_AM_Vente_creationOL.When L'utilisateur sélectionne un Site : "Z COREAL (ZCO)"
    01_AM_Vente_creationOL.Then "Z COREAL (ZCO)" est affiché dans le champ
    01_AM_Vente_creationOL.And l'utilisateur saisit le 'Tiers donneur d'ordre' dans le champ
    01_AM_Vente_creationOL.And l'utilisateur click sur le bouton enregisterer
    01_AM_Vente_creationOL.Then L'utilisateur est redirigeé vers les details des ordres de livraison
    01_AM_Vente_creationOL.When l'utilisateur clique sur le bouton + pour ajouter un produit
    01_AM_Vente_creationOL.Then Un formulaire de sélection de produit s'affiche dans une fenêtre pop-up
    01_AM_Vente_creationOL.And L'utilisateur saisit le nom Produit dans le champ Produit
    01_AM_Vente_creationOL.Given l'utilisateur saisit la quantité à livrer dans le champ Quantité
    01_AM_Vente_creationOL.When L'utilisateur saisit le Silo dans le champ Silo
    01_AM_Vente_creationOL.When l'utilisateur clique sur le bouton enregistrer
    01_AM_Vente_creationOL.And l'utiloisateur ajoute un autre produit
    01_AM_Vente_creationOL.Given l'utilisateur saisit la quantité à livrer2 dans le champ Quantité
    01_AM_Vente_creationOL.When L'utilisateur saisit le Silo2 dans le champ Silo
    01_AM_Vente_creationOL.When l'utilisateur clique sur le bouton enregistrer1
    01_AM_Vente_creationOL.When l'utilisateur freme le formulaire d'ajout de produit en cliquand sur le bouton Fermer
    01_AM_Vente_creationOL.Then Le formulaire d'ajout de produit se ferme et les détails de l'ordre de livraison sont affichés
    01_AM_Vente_creationOL.And la liste dans le tableau Détail(s) de l'ordre de livraison se met ajour
    01_AM_Vente_creationOL.When L'utilisateur clique sur le bouton 'Valider'
    01_AM_Vente_creationOL.Then Une fenêtre de confirmation affiche les informations suivantes
    01_AM_Vente_creationOL.And cliquer sur enregistrer pour enregistrer les informations
    01_AM_Vente_creationOL.Then Un document PDF contenant les informations pour l'ordre de livraison s'ouvre dans un nouvel onglet avec le statut validé
    02_AM_Vente_Transformation_OL_en_BL.When L'utilisateur clique sur le bouton 'Loupe'
    02_AM_Vente_Transformation_OL_en_BL.When l'utilisateur double-clique sur la ligne
    02_AM_Vente_Transformation_OL_en_BL.Then Le formulaire d'ordre de livraison est affiché avec les champs initialisés: Preneur d'ordre,Type d'ordre de livraison, Site,Date de livraison souhait,Date de départ,Date de l'ordre de livraison, Moment
    02_AM_Vente_Transformation_OL_en_BL.When L'utilisateur clique sur "Détails" puis continue
    02_AM_Vente_Transformation_OL_en_BL.Then L'utilisateur est redirigé vers la fenêtre de détails de l'ordre de livraison
    02_AM_Vente_Transformation_OL_en_BL.When L'utilisateur clique sur "Validation Particulière"
    02_AM_Vente_Transformation_OL_en_BL.Then Un pop-up de validation particulière s'affiche avec les cases à cocher:
    02_AM_Vente_Transformation_OL_en_BL.When L'utilisateur coche la case 'Validée et BL généré'
    02_AM_Vente_Transformation_OL_en_BL.And l'utilisateur clique sur "Enregistrer"
    02_AM_Vente_Transformation_OL_en_BL.Then Deux documents PDF (OL et BL) sont affichés contenant les informations pour l'ordre de livraison et le Bon de livraison
    #02_AM_Vente_Transformation_OL_en_BL.When L'utilisateur vérifie le statut dans la liste des OL
    03_AM_Vente_Modification_des_prix_des_produits__BL_avant_facturation.And L'utilisateur se trouve sur le menu principal de l'application
    03_AM_Vente_Modification_des_prix_des_produits__BL_avant_facturation.When L'utilisateur clique sur "PRIOS A-M Ventes"
    03_AM_Vente_Modification_des_prix_des_produits__BL_avant_facturation.When L'utilisateur sélectionne "Bons de livraison" dans la deuxième colonne
    03_AM_Vente_Modification_des_prix_des_produits__BL_avant_facturation.When L'utilisateur sélectionne Bons de livraison dans la troisième colonne
    03_AM_Vente_Modification_des_prix_des_produits__BL_avant_facturation.Then L'utilisateur L'utilisateur est redirigé vers un formulaire contenant une liste des bons de livraison, avec un bouton pour ajouter, un lien pour modifier les données, ainsi que des filtres pour effectuer des recherches selon différents critères.
    03_AM_Vente_Modification_des_prix_des_produits__BL_avant_facturation.When l'utilisateur clique sur le bouton "Loupe"
    03_AM_Vente_Modification_des_prix_des_produits__BL_avant_facturation.Then La liste des bons de livraison se met à jour avec les données de chaque BL
    03_AM_Vente_Modification_des_prix_des_produits__BL_avant_facturation.And Les BL en rouge sont facturés
    03_AM_Vente_Modification_des_prix_des_produits__BL_avant_facturation.When L'utilisateur sélectionne un BL non facturé dans la liste, par exemple : EARL DP_TEST TIERS 13
    03_AM_Vente_Modification_des_prix_des_produits__BL_avant_facturation.Then Le formulaire de BL s'affiche
    03_AM_Vente_Modification_des_prix_des_produits__BL_avant_facturation.When L'utilisateur clique sur le bouton "détail"
    03_AM_Vente_Modification_des_prix_des_produits__BL_avant_facturation.Then L'utilisateur est redirigé vers la fenêtre de détails du bon de livraison
    03_AM_Vente_Modification_des_prix_des_produits__BL_avant_facturation.When L'utilisateur sélectionne le produit qui n'a pas de prix net appliqué
    03_AM_Vente_Modification_des_prix_des_produits__BL_avant_facturation.Then Le formulaire de détails du BL s'ouvre
    03_AM_Vente_Modification_des_prix_des_produits__BL_avant_facturation.When L'utilisateur sélectionne l'onglet "Tarification"
    03_AM_Vente_Modification_des_prix_des_produits__BL_avant_facturation.Then Les informations suivantes s'affichent : Dates appliquées,Tarifs appliqués,Dates proposées,Tarifs proposés,TVA appliquée
    03_AM_Vente_Modification_des_prix_des_produits__BL_avant_facturation.When L'utilisateur saisit un prix sur le champ prix brut unitaire forcé sur "Tarifs appliqués"
    03_AM_Vente_Modification_des_prix_des_produits__BL_avant_facturation.When La valeur '100' s'affiche dans le champ "Prix brut unitaire forcé"
    03_AM_Vente_Modification_des_prix_des_produits__BL_avant_facturation.When L'utilisateur sélectionne 'Forçage BL (FBL)' sur la liste déroulante : Motif de forçage du prix
    03_AM_Vente_Modification_des_prix_des_produits__BL_avant_facturation.Then Le motif de forçage du prix Forcage BL (FBL) est sélectionné
    03_AM_Vente_Modification_des_prix_des_produits__BL_avant_facturation.When L'utilisateur clique sur "Enregistrer"
    03_AM_Vente_Modification_des_prix_des_produits__BL_avant_facturation.Then Les détails du bon de livraison s'affichent, avec le prix correctement appliqué
    03_AM_Vente_Modification_des_prix_des_produits__BL_avant_facturation.And l'utilisateur ferme le 1er pop up
    03_AM_Vente_Modification_des_prix_des_produits__BL_avant_facturation.And l'utilisateur ferme le 2eme pop up
    04_AM_Vente_Facturation_dun_BL.And L'utilisateur se trouve sur le menu principal de l'application
    04_AM_Vente_Facturation_dun_BL.When L'utilisateur clique sur "PRIOS A-M Ventes"
    04_AM_Vente_Facturation_dun_BL.When L'utilisateur choisit "Facturation" dans la deuxième colonne
    04_AM_Vente_Facturation_dun_BL.When L'utilisateur sélectionne "Traitement de factures" dans la troisième colonne
    04_AM_Vente_Facturation_dun_BL.Then L'utilisateur est redirigé vers un formulaire contenant une liste des traitements de factures de vente
    04_AM_Vente_Facturation_dun_BL.When L'utilisateur clique sur le bouton '+'
    04_AM_Vente_Facturation_dun_BL.Then L'utilisateur est redirigé vers un formulaire pour ajouter un nouveau traitement de facturation.
    04_AM_Vente_Facturation_dun_BL.when L'utilisateur saisit la date du jour dans le champ 'Date de facturation'
    04_AM_Vente_Facturation_dun_BL.Then La date du jour s'affiche dans le champ 'Date de facturation'
    04_AM_Vente_Facturation_dun_BL.When L'utilisateur saisit la date du jour dans le champ 'Fin d'extraction des mouvements'
    04_AM_Vente_Facturation_dun_BL.Then La date de fin d'extraction des mouvements est correctement saisie
    04_AM_Vente_Facturation_dun_BL.When L'utilisateur saisit le numéro du BL dans le champ 'Bon de livraison'
    04_AM_Vente_Facturation_dun_BL.Then Le numéro du BL est correctement ajouté dans le champ 'Bon de livraison'
    04_AM_Vente_Facturation_dun_BL.Then L'utilisateur clique sur "Enregistrer"
    04_AM_Vente_Facturation_dun_BL.Then Un traitement de facturation de vente est ajouté à la liste des traitements de factures
    04_AM_Vente_Facturation_dun_BL.When L'utilisateur fait un clic droit sur le traitement de facture dans la liste créé précédemment, puis clique sur "Simulation"
    04_AM_Vente_Facturation_dun_BL.Then Une popup de demande de confirmation du lancement de la simulation s'affiche, et l'utilisateur Clique sur ok pour lancer le traitement de simulation.
    04_AM_Vente_Facturation_dun_BL.And La liste des BL traités par la simulation s'affiche en PDF dans un autre onglet

























