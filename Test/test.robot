*** Settings ***
Library    SeleniumLibrary    run_on_failure=Capture Page Screenshot
Library    OperatingSystem
Library    Collections
Resource    Authentification/login_page.robot
Resource    01.PRIOS_A-M_Ventes/01_AM_Vente.robot

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
    01_AM_Vente.Given L'utilisateur se trouve sur la page "Plateformes métier"
    01_AM_Vente.When L'utilisateur sélectionne l'option "PRIOS Agriculture" dans la section "Plateformes métier"
    01_AM_Vente.Then Il est redirigé vers une nouvelle page avec les menus de navigation
    01_AM_Vente.Then Les menus de navigation affichent les options suivantes dans les premières "8" options :
    01_AM_Vente.Then Les menus de navigation affichent les options suivantes :
    01_AM_Vente.When L'utilisateur clique sur "PRIOS A-M Ventes"
    01_AM_Vente.Then L'affichage de la page présente les fonctions suivantes dans la première partie de la deuxième colonne :
    01_AM_Vente.Then L'affichage de la page présente les fonctions suivantes dans la seconde partie de la deuxième colonne :
    01_AM_Vente.When L'utilisateur sélectionne "Ordres de livraison" dans la deuxième colonne
    01_AM_Vente.Then Les fonctions suivantes apparaissent dans la première partie de la troisième colonne :
    01_AM_Vente.Then Les fonctions suivantes apparaissent dans la seconde partie de la troisième colonne :
    01_AM_Vente.When L'utilisateur sélectionne Ordres de livraison dans la troisième colonne
    01_AM_Vente.Then L'utilisateur est redirigé vers un formulaire contenant une liste vide d'ordres de livraison
    01_AM_Vente.When L'utilisateur clique sur le bouton "+"
    01_AM_Vente.Then L'utilisateur est redirigé vers un formulaire pour ajouter un nouvel ordre de livraison
    01_AM_Vente.And Si une commande a déjà été créée, alors le formulaire récupère les informations précédemment saisies pour le Preneur d'ordre
    01_AM_Vente.L'utilisateur sélectionne un type d'ordre de livraison : "OL Standard (STD)"
    01_AM_Vente.Then "OL Standard (STD)" est affiché dans le champ
    01_AM_Vente.When L'utilisateur sélectionne un Site : "Z COREAL (ZCO)"
    01_AM_Vente.Then "Z COREAL (ZCO)" est affiché dans le champ
    01_AM_Vente.When L'utilisateur recherche le 'Tiers donneur d'ordre' en cliquant sur le bouton 'loupe'
    01_AM_Vente.And L'utilisateur saisit le nom "dp_test" et effectue la recherche




