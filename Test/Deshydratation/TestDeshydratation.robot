*** Settings ***

Library    SeleniumLibrary    run_on_failure=Capture Page Screenshot
Library    OperatingSystem
Library    Collections
Resource   AuthentificationDeshy.robot
Resource   Deshy_01_Creation_parcelle.robot



*** Variables ***
${DRIVER_PATH}   chromedriver-win64 (1)/chromedriver.exe
${BROWSER}        Chrome
${BASE_URL}    http://portail-rec-0072.cloud-prios.fr
${USERNAME}    prios.support@deshyouest.fr
${PASSWORD}    Pr10s44@
${Ent_Type_tiers}     106757
${Ent_code_tiers}     106757 / BRIANTAIS
${Ent_code_commune}     35264
${Ent_code_Recolte}     2024
${COMBOBOX}    xpath=//mat-select[@id='mat-select-8']
${YEAR}        2024
${SELECT_XPATH}    xpath=//mat-select[@id='mat-select-2']
${OPTION_XPATH}    xpath=//mat-option[contains(text(), '106757 / BRIANTAIS')]
${SELECTED_VALUE_XPATH}    xpath=//span[contains(@class, 'mat-select-value-text')]
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
       Deshy_01_Creation_parcelle.When l'utilisateur clique sur le bouton "Créer parcelle"
       Deshy_01_Creation_parcelle.When l'utilisateur saisit au moin 3 caractères dans le champ "Tiers" et sélectionne le type de tiers
       Deshy_01_Creation_parcelle.When l'utilisateur saisit les 3 premiers caractères dans le champ "Commune" et sélectionne la commune
       Deshy_01_Creation_parcelle.When l'utilisateur saisit le surface
       Deshy_01_Creation_parcelle.When l'utilisateur saisit la référence chez le tiers avec la date du jour au format AAMMJJHHMM
       Deshy_01_Creation_parcelle.When l'utilisateur choisit une récolte dans le champ "Récolte"
       Deshy_01_Creation_parcelle.When l'utilisateur sélectionne une dans le champ "Espèces"
       Deshy_01_Creation_parcelle.When l'utilisateur sélectionne un site prévisionnel dans le champ "Site prévisionnel"
       Deshy_01_Creation_parcelle.When l'utilisateur sélectionne un processus de transport dans le champ "Processus de transport"
       Deshy_01_Creation_parcelle.When l'utilisateur sélectionne un type de mouvement dans la partie "Coupe"
       Deshy_01_Creation_parcelle.When l'utilisateur sélectionne une présentation dans le champ "Présentation"
       Deshy_01_Creation_parcelle.When l'utilisateur sélectionne un type de déchargement dans le champ "Type de déchargement"
       Deshy_01_Creation_parcelle.When l'utilisateur sélectionne un lieu de livraison dans le champ "Lieu de livraison"
       Deshy_01_Creation_parcelle.When l'utilisateur clique sur le bouton "Enregistrer"





