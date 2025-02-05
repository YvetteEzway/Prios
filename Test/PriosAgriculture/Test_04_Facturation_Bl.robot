*** Settings ***
Library    SeleniumLibrary    run_on_failure=Capture Page Screenshot
Library    OperatingSystem
Library    Collections
Library    DateTime

Resource    Authentification/login_page.robot
Resource    01.PRIOS_A-M_Ventes/01_AM_Vente_creationOL.robot
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
Facturation d'un BL
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





