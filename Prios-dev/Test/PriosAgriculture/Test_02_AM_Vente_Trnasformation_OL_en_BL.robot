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
Login And Navigate to Transformation OL en BL
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
    01_AM_Vente_creationOL.When L'utilisateur sélectionne "Ordres de livraison" dans la deuxième colonne
    01_AM_Vente_creationOL.When L'utilisateur sélectionne Ordres de livraison dans la troisième colonne
    01_AM_Vente_creationOL.Then L'utilisateur est redirigé vers un formulaire contenant une liste vide d'ordres de livraison
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
