*** Settings ***
Library    SeleniumLibrary    run_on_failure=Capture Page Screenshot
Library    OperatingSystem
Library    Collections
Resource    Authentification/login_page.robot
Resource    01.PRIOS_A-M_Ventes/01_AM_Vente_creationOL.robot
Resource    01.PRIOS_A-M_Ventes/02_AM_Vente_Transformation_OL_en_BL.robot
Resource    01.PRIOS_A-M_Ventes/03_AM_Vente_Modification_des_prix_des_produits__BL_avant_facturation.robot


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
Modification des prix des produits avant facturation
    [Documentation]
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







