*** Settings ***
Library    SeleniumLibrary      run_on_failure=Capture Page Screenshot
Library    OperatingSystem
Library    RequestsLibrary

*** Variables ***
${Ent_Type_tiers}     106757
${Ent_code_tiers}     106757 / BRIANTAIS
${Ent_code_commune}     35264
${Ent_code_Recolte}     2024
${COMBOBOX}    xpath=//mat-select[@id='mat-select-8']
${YEAR}        2024
${SELECT_XPATH}    xpath=//mat-select[@id='mat-select-2']
${OPTION_XPATH}    xpath=//mat-option[contains(text(), '106757 / BRIANTAIS')]
${SELECTED_VALUE_XPATH}    xpath=//span[contains(@class, 'mat-select-value-text')]

*** Keywords ***
Verify Home Page
    Wait Until Page Contains   Applications    20s
    Page Should Contain     Applications

Setup Test Environment
    Log    Setting up the test environment

Teardown Test Environment
    Log    Tearing down the test environment

Given L'utilisateur se trouve sur la page "Plateformes métier"
    [Documentation]    Vérifie que l'utilisateur est sur la page "Plateformes métier".
    Wait Until Page Contains    Plateformes    20s

When l'utilisateur clique sur le module "Déshydratation"
  [Documentation]    Sélectionne le module "Déshydratation" sur la page.
  Wait Until Element Is Visible    xpath=//div[@class='app_name']    20s
  Click Element    xpath=//div[@class='app_name']

Then Il est redirigé vers une nouvelle page avec les menus de navigation
    [Documentation]    Vérifie que la nouvelle page contient le texte spécifique pour confirmer la redirection.
    # Ouvrir l'onglet contenant les options (assurez-vous que vous êtes dans le bon onglet)
    ${handles} =    Get Window Handles
    Switch Window    ${handles}[-1]
    Sleep    20s
    Wait Until Page Contains    Culture

When l'utilisateur clique sur le bouton "Créer parcelle"
    Wait Until Element Is Visible    xpath=//span[normalize-space()='Création parcelle']
    Click Element    xpath=//span[normalize-space()='Création parcelle']

When l'utilisateur saisit au moin 3 caractères dans le champ "Tiers" et sélectionne le type de tiers
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'mat-form-field-infix')]//mat-select[@id='mat-select-2']
    Wait Until Element Is Not Visible    xpath=//div[contains(@class, 'dark-overlay')]    10s
    Wait Until Element Is Visible    xpath=//mat-select[@id='mat-select-2']    10s
    Wait Until Element Is Enabled    xpath=//mat-select[@id='mat-select-2']    10s
    Scroll Element Into View    xpath=//mat-select[@id='mat-select-2']
    Click Element    xpath=//mat-select[@id='mat-select-2']

    # 2. Saisir '106757' dans le champ de recherche
    Press Keys    xpath=//mat-select[@id='mat-select-2']    ${Ent_Type_tiers}
    Press Keys    xpath=//mat-select[@id='mat-select-2']   ENTER


When l'utilisateur saisit les 3 premiers caractères dans le champ "Commune" et sélectionne la commune
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'container_value')]//pr-dropdown//mat-form-field//mat-select[@id='mat-select-4']
    Wait Until Element Is Not Visible    xpath=//div[contains(@class, 'dark-overlay')]   30s
    Wait Until Element Is Visible    xpath=//mat-select[@id='mat-select-4']    20s
    Wait Until Element Is Enabled    xpath=//mat-select[@id='mat-select-4']  20s
    Scroll Element Into View    xpath=//mat-select[@id='mat-select-4']
    Click Element    xpath=//mat-select[@id='mat-select-4']

    # 2. Saisir  dans le champ de recherche
    Press Keys    xpath=//mat-select[@id='mat-select-4']   ${Ent_code_commune}
    Press Keys    xpath=//mat-select[@id='mat-select-4']  ENTER


When l'utilisateur saisit le surface
    Wait Until Element Is Visible    xpath=//input[@id='mat-input-0']
    Input Text   xpath=//input[@id='mat-input-0']    25000

When l'utilisateur saisit la référence chez le tiers avec la date du jour au format AAMMJJHHMM
    Wait Until Element Is Visible    xpath=//*[@id="mat-input-1"]
    Input Text    xpath=//*[@id="mat-input-1"]    240917

When l'utilisateur choisit une récolte dans le champ "Récolte"

    Wait Until Element Is Visible    xpath=//*[@id="mat-dialog-0"]/pr-farming-cut-create/pr-farming-cut-main/div/mat-dialog-content/div/div/div/div[1]/div[2]/div[2]/mat-grid-list/div/mat-grid-tile[5]/div/pr-common-form-main/div/div[2]     10s

    Wait Until Element Is Visible    xpath=//*[@id="mat-select-8"]/div  10s
    Wait Until Element Is Enabled    xpath=//*[@id="mat-select-8"]/div  10s
    Execute JavaScript  document.querySelector('#mat-select-8 > div').click(); setTimeout(() => { const options = document.querySelectorAll('mat-option'); options.forEach(option => { if (option.innerText.includes('2024')) { option.click(); } }); }, 1000);
When l'utilisateur sélectionne une dans le champ "Espèces"

    Wait Until Element Is Visible    xpath=//*[@id="mat-select-value-11"]  10s
    Wait Until Element Is Enabled    xpath=//*[@id="mat-select-value-11"]  10s
    Execute JavaScript  document.querySelector('#mat-select-value-11').click(); setTimeout(() => { const options = document.querySelectorAll('mat-option'); options.forEach(option => { if (option.innerText.includes('LUZ / LUZERNE')) { option.click(); } }); }, 1000);

When l'utilisateur sélectionne un site prévisionnel dans le champ "Site prévisionnel"

    Wait Until Element Is Visible    xpath=//*[@id="mat-select-value-13"]   10s
    Wait Until Element Is Enabled    xpath=//*[@id="mat-select-value-13"]   10s
    Execute JavaScript  document.querySelector('#mat-select-value-13').click(); setTimeout(() => { const options = document.querySelectorAll('mat-option'); options.forEach(option => { if (option.innerText.includes('AD / Atelier DOMAGNE')) { option.click(); } }); }, 1000);
When l'utilisateur sélectionne un processus de transport dans le champ "Processus de transport"

     Wait Until Element Is Visible    xpath=//*[@id="mat-select-value-21"]  10s
     Wait Until Element Is Enabled    xpath=//*[@id="mat-select-value-21"]  10s
     Execute JavaScript  document.querySelector('#mat-select-value-21').click(); setTimeout(() => { const options = document.querySelectorAll('mat-option'); options.forEach(option => { if (option.innerText.includes('CS / Collecte')) { option.click(); } }); }, 1000);
When l'utilisateur sélectionne un type de mouvement dans la partie "Coupe"

     Wait Until Element Is Visible    xpath=//*[@id="mat-select-value-23"]  10s
     Wait Until Element Is Enabled    xpath=//*[@id="mat-select-value-23"]  10s
     Execute JavaScript  document.querySelector('#mat-select-value-23').click(); setTimeout(() => { const options = document.querySelectorAll('mat-option'); options.forEach(option => { if (option.innerText.includes('G06 /  Granulés 6 mm')) { option.click(); } }); }, 1000);
When l'utilisateur sélectionne une présentation dans le champ "Présentation"
     Wait Until Element Is Visible    xpath=//*[@id="mat-select-value-25"]  10s
     Wait Until Element Is Enabled    xpath=//*[@id="mat-select-value-25"]  10s
     Execute JavaScript  document.querySelector('#mat-select-value-25').click(); setTimeout(() => { const options = document.querySelectorAll('mat-option'); options.forEach(option => { if (option.innerText.includes('LTR / (C) Livré par un TRANSPORTEUR')) { option.click(); } }); }, 1000);
When l'utilisateur sélectionne un type de déchargement dans le champ "Type de déchargement"
     Wait Until Element Is Visible    xpath=//*[@id="mat-select-value-27"]  10s
     Wait Until Element Is Enabled    xpath=//*[@id="mat-select-value-27"]  10s
     Execute JavaScript  document.querySelector('#mat-select-value-27').click(); setTimeout(() => { const options = document.querySelectorAll('mat-option'); options.forEach(option => { if (option.innerText.includes('SA / Sans')) { option.click(); } }); }, 1000);
When l'utilisateur sélectionne un lieu de livraison dans le champ "Lieu de livraison"
     Wait Until Element Is Visible    xpath=//*[@id="mat-select-value-29"]  10s
     Wait Until Element Is Enabled    xpath=//*[@id="mat-select-value-29"]  10s
     Execute JavaScript  document.querySelector('#mat-select-value-29').click(); setTimeout(() => { const options = document.querySelectorAll('mat-option'); options.forEach(option => { if (option.innerText.includes('L01 / 6 LA PIAIZIERE')) { option.click(); } }); }, 1000);

When l'utilisateur clique sur le bouton "Enregistrer"

    Execute Javascript  document.querySelector('div.container_button.right_container > div > div:nth-child(2)').click()

When l'utilisateur clique sur le bouton Confirmer dans le pop up de confirmation

    Wait Until Element Is Visible    xpath=//*[@id="cdk-overlay-22"]
    Wait Until Element Is Visible    locator
