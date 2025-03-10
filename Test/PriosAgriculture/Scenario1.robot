*** Settings ***
Library    SeleniumLibrary    run_on_failure=Capture Page Screenshot
Library    OperatingSystem
Library    Collections
Resource    Authentification/login_page.robot
Resource    01.PRIOS_A-M_Ventes/Scenario_création_OL.robot

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
    Capture Page Screenshot   password.png
    login_page.Click Login Button
    Scenario_création_OL.Given L'utilisateur se trouve sur la page "Plateformes métier"
    Scenario_création_OL.When L'utilisateur sélectionne l'option "PRIOS Agriculture" dans la section "Plateformes métier"
    Scenario_création_OL.Then Il est redirigé vers une nouvelle page avec les menus de navigation
    Scenario_création_OL.Then Les menus de navigation affichent :
    Scenario_création_OL.When L'utilisateur clique sur "PRIOS A-M Ventes"
    Scenario_création_OL.When L'utilisateur sélectionne "Ordres de livraison" dans la deuxième colonne
    Scenario_création_OL.When L'utilisateur sélectionne Ordres de livraison dans la troisième colonne
    Scenario_création_OL.When L'utilisateur clique sur le bouton "+"
    Scenario_création_OL.L'utilisateur sélectionne un type d'ordre de livraison : "OL Standard (STD)"
    Scenario_création_OL.When L'utilisateur sélectionne un Site : "Z COREAL (ZCO)"
    Scenario_création_OL.And l'utilisateur saisit le 'Tiers donneur d'ordre' dans le champ
    Scenario_création_OL.And l'utilisateur click sur le bouton enregisterer
    #Scenario_création_OL.When l'utilisateur clique sur le bouton + pour ajouter un produit
    #Scenario_création_OL.And l'utilisateur saisit le nom Produit dans le champ Produit
    #Scenario_création_OL.Given l'utilisateur saisit la quantité à livrer dans le champ Quantité
    #Scenario_création_OL.When L'utilisateur saisit le Silo dans le champ Silo
    #Scenario_création_OL.When l'utilisateur clique sur le bouton enregistrer
    #Scenario_création_OL.And l'utiloisateur ajoute un autre produit
    #Scenario_création_OL.Given l'utilisateur saisit la quantité à livrer2 dans le champ Quantité
    #Scenario_création_OL.When L'utilisateur saisit le Silo2 dans le champ Silo
    #Scenario_création_OL.When l'utilisateur clique sur le bouton enregistrer1
    #Scenario_création_OL.When l'utilisateur freme le formulaire d'ajout de produit en cliquand sur le bouton Fermer
    #Scenario_création_OL.When L'utilisateur clique sur le bouton 'Valider'



