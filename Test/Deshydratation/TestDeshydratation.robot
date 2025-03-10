*** Settings ***

Library    SeleniumLibrary    run_on_failure=Capture Page Screenshot
Library    OperatingSystem
Library    Collections
Resource   AuthentificationDeshy.robot
Resource   Deshy_01_Creation_parcelle.robot



*** Variables ***
${DRIVER_PATH}   chromedriver-win64 (2)/chromedriver.exe
${BROWSER}        Chrome
${BASE_URL}    http://portail-rec-0072.cloud-prios.fr
${USERNAME}    prios.support@deshyouest.fr
${PASSWORD}    Pr10s44@

${TEST SETUP}    Setup Test Environment
${TEST TEARDOWN}    Teardown Test Environment

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
Login et navigation vers Déshydratation
       [Documentation]
       Open Browser With Options   ${BASE_URL}
       AuthentificationDeshy.Enter Email   ${USERNAME}
       AuthentificationDeshy.Click Submit Button
       AuthentificationDeshy.Enter Password  ${PASSWORD}
       AuthentificationDeshy.Click Login Button
       AuthentificationDeshy.Click Button2
       Deshy_01_Creation_parcelle.Verify Home Page
       Deshy_01_Creation_parcelle.Given L'utilisateur se trouve sur la page "Plateformes métier"
       Deshy_01_Creation_parcelle.When l'utilisateur clique sur le module "Déshydratation"
       Deshy_01_Creation_parcelle.Then Il est redirigé vers une nouvelle page avec les menus de navigation
       Deshy_01_Creation_parcelle.Suppresion de la dernière ligne avant de créer une parcelle
       Deshy_01_Creation_parcelle.When l'utilisateur clique sur le bouton "Créer parcelle"
       Deshy_01_Creation_parcelle.When l'utilisateur saisit au moin 3 caractères dans le champ "Tiers" et sélectionne le type de tiers
       Deshy_01_Creation_parcelle.When l'utilisateur saisit les 3 premiers caractères dans le champ "Commune" et sélectionne la commune
       Deshy_01_Creation_parcelle.When l'utilisateur saisit le surface
       Deshy_01_Creation_parcelle.When l'utilisateur saisit la référence chez le tiers
       Deshy_01_Creation_parcelle.When l'utilisateur choisit une récolte dans le champ "Récolte"
       Deshy_01_Creation_parcelle.When l'utilisateur sélectionne une dans le champ "Espèces"
       Deshy_01_Creation_parcelle.When l'utilisateur sélectionne un site prévisionnel dans le champ "Site prévisionnel"
       Deshy_01_Creation_parcelle.When l'utilisateur sélectionne un processus de transport dans le champ "Type de mouvement"
       Deshy_01_Creation_parcelle.When l'utilisateur sélectionne un type de mouvement dans la partie "Présentation"
       Deshy_01_Creation_parcelle.When l'utilisateur sélectionne une présentation dans le champ "Processus de transport"
       Deshy_01_Creation_parcelle.When l'utilisateur sélectionne un type de déchargement dans le champ "Type de déchargement"
       Deshy_01_Creation_parcelle.When l'utilisateur sélectionne un lieu de livraison dans le champ "Lieu de livraison"
       Capture Page Screenshot    livraison.png
       Deshy_01_Creation_parcelle.When l'utilisateur clique sur le bouton "Enregistrer"
       Deshy_01_Creation_parcelle.When l'utilisateur clique sur le bouton Confirmer dans le pop up de confirmation
       Deshy_01_Creation_parcelle.Then la parcelle est enregistrée et l'utilisateur est redirigé vers la liste des parcelles
       Deshy_01_Creation_parcelle.When l'utilisateur saisit la référence dans la colonne "Référence parcelle chez le tiers"
       Deshy_01_Creation_parcelle.Then la liste se met à jour et affiche uniquement la valeur de la parcelle créée précédemment
       Deshy_01_Creation_parcelle.When l'utilisateur clique sur la ligne correspondant à la parcelle








