*** Settings ***
Library    SeleniumLibrary    run_on_failure=Capture Page Screenshot
Library    OperatingSystem
Library    Collections
Resource    Authentification/login_page.robot
Resource    01.PRIOS_A-M_Ventes/01_AM_Vente_creationOL.robot
Resource    01.PRIOS_A-M_Ventes/02_AM_Vente_Transformation_OL_en_BL.robot
Resource    01.PRIOS_A-M_Ventes/03_AM_Vente_Modification_des_prix_des_produits__BL_avant_facturation.robot
Resource    02.A-M Ventes_Eng_01/01_Engagement_vente.robot

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

