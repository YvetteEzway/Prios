*** Settings ***
Library    SeleniumLibrary      run_on_failure=Capture Page Screenshot
Library    OperatingSystem
Library    RequestsLibrary
Library    BuiltIn
Library    String



*** Variables ***
${Ent_Type_tiers}     106757
${Ent_code_tiers}     106757 / BRIANTAIS
${Ent_code_commune}    35264 / ST DIDIER
${XPATH_SELECTOR}      xpath=/html/body/pr-root/div[2]/pr-farming-main/div/div[2]/ag-grid-angular/div/div[2]/div[2]/div[6]/div[1]
${TABLE_COLUMN_XPATH}    xpath=/html/body/pr-root/div[2]/pr-farming-main/div/div[2]/ag-grid-angular/div/div[2]/div[2]/div[1]/div[2]/div/div[1]/div
${HORIZONTAL_SCROLL_ELEMENT_XPATH}    xpath=/html/body/pr-root/div[2]/pr-farming-main/div/div[2]/ag-grid-angular/div/div[2]/div[2]/div[6]/div[2]/div
${REFERENCE_COLONNE_XPATH}     xpath=/html/body/pr-root/div[2]/pr-farming-main/div/div[2]/ag-grid-angular/div/div[2]/div[2]/div[1]/div[2]/div/div[1]/div[4]/div[3]/div/div/span[1]
${REFERENCE_VALUE}    24110513

${TABLE_CELLS_XPATH}             xpath=/html/body/pr-root/div[2]/pr-farming-main/div/div[2]/ag-grid-angular/div/div[2]/div[2]/div[3]/div[1]/div/div[2]/div/div/div/div
${HORIZONTAL_SCROLL_AMOUNT}     100
*** Keywords ***
Verify Home Page
    Wait Until Page Contains   Applications    10s
    Page Should Contain     Applications

Setup Test Environment
    Log    Setting up the test environment

Teardown Test Environment
    Log    Tearing down the test environment

Given L'utilisateur se trouve sur la page "Plateformes métier"
    [Documentation]    Vérifie que l'utilisateur est sur la page "Plateformes métier".
    Wait Until Page Contains    Plateformes    10s

When l'utilisateur clique sur le module "Déshydratation"
  [Documentation]    Sélectionne le module "Déshydratation" sur la page.
  Wait Until Element Is Visible    xpath=//div[@class='app_name']    5s
  Click Element    xpath=//div[@class='app_name']

Then Il est redirigé vers une nouvelle page avec les menus de navigation
    [Documentation]    Vérifie que la nouvelle page contient le texte spécifique pour confirmer la redirection.
    # Ouvrir l'onglet contenant les options (assurez-vous que vous êtes dans le bon onglet)
    ${handles} =    Get Window Handles
    Switch Window    ${handles}[-1]
    Sleep    5s
    Wait Until Page Contains    Culture

When l'utilisateur clique sur le bouton "Créer parcelle"
    Wait Until Element Is Visible    xpath=//span[normalize-space()='Création parcelle']
    Click Element    xpath=//span[normalize-space()='Création parcelle']

When l'utilisateur saisit au moin 3 caractères dans le champ "Tiers" et sélectionne le type de tiers
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'mat-form-field-infix')]//mat-select[@id='mat-select-2']
    Wait Until Element Is Not Visible    xpath=//div[contains(@class, 'dark-overlay')]    10s
    Wait Until Element Is Visible    xpath=//mat-select[@id='mat-select-2']    10s
    Wait Until Element Is Enabled    xpath=//mat-select[@id='mat-select-2']
    Scroll Element Into View    xpath=//mat-select[@id='mat-select-2']
    Click Element    xpath=//mat-select[@id='mat-select-2']

    # 2. Saisir '106757' dans le champ de recherche
    Press Keys    xpath=//mat-select[@id='mat-select-2']    ${Ent_Type_tiers}
    Press Keys    xpath=//mat-select[@id='mat-select-2']   ENTER

When l'utilisateur saisit les 3 premiers caractères dans le champ "Commune" et sélectionne la commune
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'container_value')]//pr-dropdown//mat-form-field//mat-select[@id='mat-select-4']
    Wait Until Element Is Not Visible    xpath=//div[contains(@class, 'dark-overlay')]   10s
    Wait Until Element Is Visible    xpath=//*[@id="mat-select-value-5"]    10s
    Wait Until Element Is Enabled    xpath=//*[@id="mat-select-value-5"]   10s
    Scroll Element Into View    xpath=//*[@id="mat-select-value-5"]
    Click Element    xpath=//*[@id="mat-select-value-5"]
    Sleep    1s  # Pause pour permettre l'ouverture du champ

# Saisir la valeur dans le champ de recherche
    Press Keys    xpath=//*[@id="mat-option-6"]/span/ngx-mat-select-search/div/input    ${Ent_code_commune}
    Sleep    5s
    Press Keys    xpath=//*[@id="mat-option-6"]/span/ngx-mat-select-search/div/input    SPACE  # Ajout d'un espace après la valeur
    Sleep    2s  # Attendre pour permettre la mise à jour des résultats

# Vérifier si l'option est visible et la sélectionner
    Wait Until Element Is Visible    xpath=//mat-option[contains(@class, 'mat-option') and contains(., '${Ent_code_commune}')]    10s
    Click Element    xpath=//mat-option[contains(@class, 'mat-option') and contains(., '${Ent_code_commune}')]

When l'utilisateur saisit le surface
    Wait Until Element Is Visible    xpath=//input[@id='mat-input-0']
    Input Text   xpath=//input[@id='mat-input-0']    25

When l'utilisateur saisit la référence chez le tiers avec la date du jour au format AAMMJJHHMM
    Wait Until Element Is Visible    xpath=//*[@id="mat-input-1"]
    Input Text    xpath=//*[@id="mat-input-1"]    24110513
When l'utilisateur choisit une récolte dans le champ "Récolte"
    Wait Until Element Is Visible    xpath=//*[@id="mat-dialog-0"]/pr-farming-cut-create/pr-farming-cut-main/div/mat-dialog-content/div/div/div/div[1]/div[2]/div[2]/mat-grid-list/div/mat-grid-tile[5]/div/pr-common-form-main/div/div[2]     10s
    Wait Until Element Is Visible    xpath=//*[@id="mat-select-8"]/div  10s
    Wait Until Element Is Enabled    xpath=//*[@id="mat-select-8"]/div
    Execute JavaScript  document.querySelector('#mat-select-8 > div').click(); setTimeout(() => { const options = document.querySelectorAll('mat-option'); options.forEach(option => { if (option.innerText.includes('2024')) { option.click(); document.activeElement.blur(); } }); }, 1000);

When l'utilisateur sélectionne une dans le champ "Espèces"

    Wait Until Element Is Visible    xpath=//*[@id="mat-select-value-11"]  10s
    Wait Until Element Is Enabled    xpath=//*[@id="mat-select-value-11"]
    Execute JavaScript  document.querySelector('#mat-select-value-11').click(); setTimeout(() => { const options = document.querySelectorAll('mat-option'); options.forEach(option => { if (option.innerText.includes('LUZ / LUZERNE')) { option.click(); document.activeElement.blur(); } }); }, 1000);

When l'utilisateur sélectionne un site prévisionnel dans le champ "Site prévisionnel"

    Wait Until Element Is Visible    xpath=//*[@id="mat-select-value-13"]   10s
    Wait Until Element Is Enabled    xpath=//*[@id="mat-select-value-13"]
    Execute JavaScript  document.querySelector('#mat-select-value-13').click(); setTimeout(() => { const options = document.querySelectorAll('mat-option'); options.forEach(option => { if (option.innerText.includes('AD / Atelier DOMAGNE')) { option.click(); document.activeElement.blur(); } }); }, 1000);

When l'utilisateur sélectionne un processus de transport dans le champ "Type de mouvement"
     Wait Until Element Is Visible    xpath=//*[@id="mat-select-value-21"]  10s
     Wait Until Element Is Enabled    xpath=//*[@id="mat-select-value-21"]
     Execute JavaScript  document.querySelector('#mat-select-value-21').click(); setTimeout(() => { const options = document.querySelectorAll('mat-option'); options.forEach(option => { if (option.innerText.includes('CS / Collecte')) { option.click(); document.activeElement.blur(); } }); }, 1000);

When l'utilisateur sélectionne un type de mouvement dans la partie "Présentation"
     Wait Until Element Is Visible    xpath=//*[@id="mat-select-value-23"]  10s
     Wait Until Element Is Enabled    xpath=//*[@id="mat-select-value-23"]
     Execute JavaScript  document.querySelector('#mat-select-value-23').click(); setTimeout(() => { const options = document.querySelectorAll('mat-option'); options.forEach(option => { if (option.innerText.includes('G06 / Granulés 6 mm')) { option.click(); document.activeElement.blur(); } }); }, 1000);

When l'utilisateur sélectionne une présentation dans le champ "Processus de transport"
     Wait Until Element Is Visible    xpath=//*[@id="mat-select-value-25"]  10s
     Wait Until Element Is Enabled    xpath=//*[@id="mat-select-value-25"]
     Execute JavaScript  document.querySelector('#mat-select-value-25').click(); setTimeout(() => { const options = document.querySelectorAll('mat-option'); options.forEach(option => { if (option.innerText.includes('LTR / (C) Livré par un TRANSPORTEUR')) { option.click(); document.activeElement.blur(); } }); }, 1000);

When l'utilisateur sélectionne un type de déchargement dans le champ "Type de déchargement"
     Wait Until Element Is Visible    xpath=//*[@id="mat-select-value-27"]  10s
     Wait Until Element Is Enabled    xpath=//*[@id="mat-select-value-27"]
     Execute JavaScript  document.querySelector('#mat-select-value-27').click(); setTimeout(() => { const options = document.querySelectorAll('mat-option'); options.forEach(option => { if (option.innerText.includes('SA / Sans')) { option.click(); document.activeElement.blur(); } }); }, 1000);

When l'utilisateur sélectionne un lieu de livraison dans le champ "Lieu de livraison"
     Wait Until Element Is Visible    xpath=//*[@id="mat-select-value-29"]  10s
     Wait Until Element Is Enabled    xpath=//*[@id="mat-select-value-29"]
     Execute JavaScript  document.querySelector('#mat-select-value-29').click(); setTimeout(() => { const options = document.querySelectorAll('mat-option'); options.forEach(option => { if (option.innerText.includes('L01 / 6 LA PIAIZIERE')) { option.click(); document.activeElement.blur(); } }); }, 1000);
     Sleep    10s

When l'utilisateur clique sur le bouton "Enregistrer"
    Wait Until Element Is Visible    css=div.container_button.right_container > div > div:nth-child(2)  10s
    Wait Until Element Is Enabled    css=div.container_button.right_container > div > div:nth-child(2)  10s
    Execute JavaScript   document.querySelector('div.container_button.right_container > div > div:nth-child(2)').click()


When l'utilisateur clique sur le bouton Confirmer dans le pop up de confirmation

     Wait Until Element Is Visible    css:.cancel_button    10
     Click Element    css:.cancel_button

Then la parcelle est enregistrée et l'utilisateur est redirigé vers la liste des parcelles
    ${textes_entetes}=    Create List

    WHILE    True
        ${entetes_colonne}=    Get WebElements    ${TABLE_COLUMN_XPATH}

        FOR    ${entete}    IN    @{entetes_colonne}
            ${texte_entete}=    Get Text    ${entete}
            ${texte_entete}=    Replace String    ${texte_entete}    \n    ' '
            ${texte_entete}=    Strip String    ${texte_entete}

            Continue For Loop If    '${texte_entete}' == ''
            Run Keyword If    '${texte_entete}' in @{textes_entetes}    Continue For Loop

            Append To List    ${textes_entetes}    ${texte_entete}
        END

        ${current_scroll_position}=    Execute JavaScript    return document.querySelector('.ag-body-horizontal-scroll-viewport').scrollLeft
        ${max_scroll_position}=    Execute JavaScript    return document.querySelector('.ag-body-horizontal-scroll-viewport').scrollWidth - document.querySelector('.ag-body-horizontal-scroll-viewport').clientWidth

        Run Keyword If    ${current_scroll_position} >= ${max_scroll_position}    Exit For Loop

        Wait Until Page Contains Element    ${HORIZONTAL_SCROLL_ELEMENT_XPATH}
        Execute JavaScript    document.querySelector('.ag-body-horizontal-scroll-viewport').scrollLeft += document.querySelector('.ag-body-horizontal-scroll-viewport').offsetWidth
        Sleep    0.5s
    END

    Log    ${textes_entetes}
    Should Not Be Empty    ${textes_entetes}


When l'utilisateur saisit la référence dans la colonne "Référence parcelle chez le tiers"
         Wait Until Element Is Visible    xpath=/html/body/pr-root/div[2]/pr-farming-main/div/div[2]/ag-grid-angular/div/div[2]/div[2]/div[1]/div[2]/div/div[2]/div[4]   10s
        Wait Until Element Is Visible    xpath=/html/body/pr-root/div[2]/pr-farming-main/div/div[2]/ag-grid-angular/div/div[2]/div[2]/div[1]/div[2]/div/div[2]/div[4]/div[1]/div/div/div[2]/input  10s
        Wait Until Element Is Enabled    xpath=/html/body/pr-root/div[2]/pr-farming-main/div/div[2]/ag-grid-angular/div/div[2]/div[2]/div[1]/div[2]/div/div[2]/div[4]/div[1]/div/div/div[2]/input
        Click Element    xpath=/html/body/pr-root/div[2]/pr-farming-main/div/div[2]/ag-grid-angular/div/div[2]/div[2]/div[1]/div[2]/div/div[2]/div[4]/div[1]/div/div/div[2]/input
        Input Text    xpath=/html/body/pr-root/div[2]/pr-farming-main/div/div[2]/ag-grid-angular/div/div[2]/div[2]/div[1]/div[2]/div/div[2]/div[4]/div[1]/div/div/div[2]/input    24110513
        Sleep   3s
        Execute JavaScript    document.querySelector('.ag-body-horizontal-scroll-viewport').scrollLeft = 0
        Sleep  0.3s

Then la liste se met à jour et affiche uniquement la valeur de la parcelle créée précédemment
    &{donnees_par_ligne}=    Create Dictionary

    WHILE    True
        ${entetes_colonne}=    Get WebElements    ${TABLE_COLUMN_XPATH}
        ${cellules}=    Get WebElements    ${TABLE_CELLS_XPATH}

        FOR    ${index}   ${entete}    IN ENUMERATE   @{entetes_colonne}
            ${texte_entete}=    Get Text    ${entete}
            ${texte_entete}=    Replace String    ${texte_entete}    \n    ' '
            ${texte_entete}=    Strip String    ${texte_entete}

            ${texte_cellule}=    Get Text    ${cellules}[${index}]
            ${texte_cellule}=    Replace String    ${texte_cellule}    \n    ' '
            ${texte_cellule}=    Strip String    ${texte_cellule}

            Set To Dictionary    ${donnees_par_ligne}    ${texte_entete}    ${texte_cellule}
        END

        ${current_scroll_position}=    Execute JavaScript    return document.querySelector('.ag-body-horizontal-scroll-viewport').scrollLeft
        ${max_scroll_position}=    Execute JavaScript    return document.querySelector('.ag-body-horizontal-scroll-viewport').scrollWidth - document.querySelector('.ag-body-horizontal-scroll-viewport').clientWidth

        Run Keyword If    ${current_scroll_position} >= ${max_scroll_position}    Exit For Loop

        Wait Until Page Contains Element    ${HORIZONTAL_SCROLL_ELEMENT_XPATH}
        Execute JavaScript    document.querySelector('.ag-body-horizontal-scroll-viewport').scrollLeft += document.querySelector('.ag-body-horizontal-scroll-viewport').offsetWidth
        Sleep    0.5s
    END

    Log    ${donnees_par_ligne}
    Should Not Be Empty    ${donnees_par_ligne}

When l'utilisateur clique sur la ligne correspondant à la parcelle
        Execute Javascript    var updatedRow = document.evaluate("//*[contains(text(), '${REFERENCE_VALUE}')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
    ...    if (updatedRow) { updatedRow.click(); } else { console.log('Ligne non trouvée'); }

#Then les coupes s'affichent sous la première ligne et vérifiez que : les 5 lignes sont affichées avec les valeurs ajoutée précédemment.

