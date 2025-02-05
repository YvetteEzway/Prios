*** Settings ***
Library    SeleniumLibrary    run_on_failure=Capture Page Screenshot
Library    OperatingSystem
Library    RequestsLibrary
Library    BuiltIn
Library    String
Library    BuiltIn


*** Variables ***
${TABLE}    xpath=//*[@class='dgrid dgrid-grid a-grid a-widget a-grid-hide-sort-headers a-grid-inverted-sel a-grid-solid-vert']
${CHECKBOX_COL}      11
${EXPECTED_COLOR}    rgba(255, 255, 255, 1)    # Couleur blanche en RGBA
${RED_COLOR}         rgb(255, 0, 0)

${TABLE_SELECTOR}      xpath=//table[@class="dgrid-row-table"]
${VALUE_TO_FIND}       DPT1

${FIELD-ID4}        Forcage BL (FBL)
${VALEUR_RECHERCHEE}    100


*** Keywords ***
And L'utilisateur se trouve sur le menu principal de l'application
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[7]/div[1]/table/tbody/tr/td[3]/div/span[5]       30s
    Click Element    xpath=/html/body/div[2]/div[1]/div[7]/div[1]/table/tbody/tr/td[3]/div/span[5]

When L'utilisateur clique sur "PRIOS A-M Ventes"
    [Documentation]    Sélectionne l'option "PRIOS A-M Ventes" sur la page.
    Execute JavaScript    document.evaluate("//*[contains(text(), 'PRIOS A-M Ventes')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);

    Wait Until Element Is Visible    xpath=//*[contains(text(), 'PRIOS A-M Ventes')]    20s
    Click Element    xpath=//*[contains(text(), 'PRIOS A-M Ventes')]

    Sleep    10s

When L'utilisateur sélectionne "Bons de livraison" dans la deuxième colonne
    [Documentation]    Sélectionne l'option "Ordres de livraison" sur la page.
    Execute JavaScript    document.evaluate("(//*[contains(text(), 'Bons de livraison')])[1]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    Sleep    1s
    Execute JavaScript    document.evaluate("(//*[contains(text(), 'Bons de livraison')])[1]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()

    Sleep    30s

When L'utilisateur sélectionne Bons de livraison dans la troisième colonne

    [Documentation]    Sélectionne l'option "Ordres de livraison troisième colonne " sur la page.
    Execute JavaScript    document.evaluate("(//*[contains(text(), 'Bons de livraison')])[2]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    Sleep    1s
    Execute JavaScript    document.evaluate("(//*[contains(text(), 'Bons de livraison')])[2]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()

    Sleep    60s
   # Wait Until Element Is Visible    xpath=//*[contains(@class, 'dijitDialogTitle') and contains(text(), 'Bons de livraison - Sté PRIOS - Etablissement CARQUEFOU')]    timeout=60s

Then L'utilisateur L'utilisateur est redirigé vers un formulaire contenant une liste des bons de livraison, avec un bouton pour ajouter, un lien pour modifier les données, ainsi que des filtres pour effectuer des recherches selon différents critères.

    [Documentation]    Vérifie que la nouvelle page contient le texte spécifique pour confirmer la redirection.
    Page Should Contain    Bons de livraison
    Log     La liste des "Bons de livraison" est bien présent sur la page    INFO

When l'utilisateur clique sur le bouton "Loupe"
    [Documentation]    Clique sur le bouton "Loop" pour afficher tous les bons de livraison.

    Wait Until Element Is Visible    xpath=//img[contains(@class, 'a-image') and contains(@src, '540900E90F2F7123BB05B76317E76008')]      timeout=30s

    Execute JavaScript    document.evaluate("//img[contains(@class, 'a-image') and contains(@src, '540900E90F2F7123BB05B76317E76008')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    Sleep    1s
    Click Element    xpath=//img[contains(@class, 'a-image') and contains(@src, '540900E90F2F7123BB05B76317E76008')]
    Sleep    10s

Then La liste des bons de livraison se met à jour avec les données de chaque BL
# Vérifier s'il y a des valeurs dans le tableau
    ${elements}=    Get WebElements    xpath=//*[@class='dgrid dgrid-grid a-grid a-widget a-grid-hide-sort-headers a-grid-inverted-sel a-grid-solid-vert']
    ${length}=    Get Length    ${elements}
    Run Keyword If    ${length} > 0    Log    Le tableau contient des valeurs.
    Run Keyword If    ${length} == 0    Fail    Le tableau est vide.

And Les BL en rouge sont facturés
    ${rows}=    Get Webelements    xpath_to_rows
    ${red_count}=    Set Variable    0

    FOR    ${row}    IN    @{rows}
        ${bg_color}=    Execute Javascript    return window.getComputedStyle(arguments[0]).backgroundColor;    ${row}
        Log    Row color: ${bg_color}
        Run Keyword If    '${bg_color}' == 'rgb(255, 0, 0)'    Set Variable    ${red_count}    ${red_count + 1}
    END

    Log    Total red rows: ${red_count}

When L'utilisateur sélectionne un BL non facturé dans la liste, par exemple : EARL DP_TEST TIERS 13
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'dgrid-content')][last()]//table/tr/td    timeout=20s
    Execute Javascript
    ...    var element = document.evaluate("//div[contains(@class, 'dgrid-content')][last()]//table/tr/td", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
    ...    var dblClickEvent = new MouseEvent('dblclick', {
    ...        'view': window,
    ...        'bubbles': true,
    ...        'cancelable': true,
    ...        'detail': 2
    ...    });
    ...    element.focus();
    ...    element.dispatchEvent(dblClickEvent);
    Sleep    5s

Then Le formulaire de BL s'affiche
    Page Should Contain    Bon de livraison [M] - Sté PRIOS - Etablissement CARQUEFOU
    Log  Bon de livraison s'affiche

When L'utilisateur clique sur le bouton "détail"
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/button[3]
    Click Element    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/button[3]
    Sleep    5s

Then L'utilisateur est redirigé vers la fenêtre de détails du bon de livraison
    Page Should Contain    Bon de livraison détails - Sté PRIOS - Etablissement CARQUEFOU
    Log  Bon de livraison détails s'affiche

When L'utilisateur sélectionne le produit qui n'a pas de prix net appliqué
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div/div/div[3]/div[2]/div/div[2]/table/tr
    ${ROW}=    Get WebElement    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div/div/div[3]/div[2]/div/div[2]/table/tr

    Scroll Element Into View    ${ROW}
    Double Click Element    ${ROW}
    Sleep    5s

Then Le formulaire de détails du BL s'ouvre
    Page Should Contain    Affectation
    Log  Formulaire de détails du BL s'ouvre

When L'utilisateur sélectionne l'onglet "Tarification"
    Wait Until Element Is Visible    xpath=//span[@class='tabLabel' and text()='Tarifications']
    Click Element    xpath=//span[@class='tabLabel' and text()='Tarifications']

Then Les informations suivantes s'affichent : Dates appliquées,Tarifs appliqués,Dates proposées,Tarifs proposés,TVA appliquée
    Wait Until Page Contains    Dates appliquées
    Wait Until Page Contains    Tarifs appliqués    timeout=20s
    Wait Until Page Contains    Dates proposées    timeout=20s
    Wait Until Page Contains    Tarifs proposés   timeout=20s
    Wait Until Page Contains    TVA appliquée    timeout=20s
    Log    Les informations suivantes s'affichent
    Log    - Dates appliquées
    Log    - Tarifs appliqués
    Log    - Dates proposées
    Log    - Tarifs proposés
    Log    - TVA appliquée

When L'utilisateur saisit un prix sur le champ prix brut unitaire forcé sur "Tarifs appliqués"

    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[4]/div/div[38]/div/input
    Wait Until Element Is Enabled    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[4]/div/div[38]/div/input
    Input Text    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[4]/div/div[38]/div/input    100

When La valeur '100' s'affiche dans le champ "Prix brut unitaire forcé"
    ${valeur} =    Get Value    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[4]/div/div[38]/div/input
    Should Be Equal As Strings    ${valeur}    100
    Click Element    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[4]/div/div[126]/div/input

When L'utilisateur sélectionne 'Forçage BL (FBL)' sur la liste déroulante : Motif de forçage du prix
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[4]/div/div[44]/div[3]/input
    Click Element    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[4]/div/div[44]/div[3]/input
    Click Element    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[4]/div/div[44]/div[3]/input

    Wait Until Element Is Visible    xpath=(//input[@value='▼ '])[45]  250s
    Click Element                    xpath=(//input[@value='▼ '])[45]
    Sleep    30s

    # Attendre que la liste déroulante soit visible
    Wait Until Element Is Visible    xpath=//div[@class='dijitPopup dijitComboBoxMenuPopup' and not(contains(@style, 'display: none'))]    120s

# Cliquer sur l'élément Forcage BL (FBL)
    Click Element    xpath=//div[@class='a-combosimplemenuitem'][normalize-space(text())='Forcage BL (FBL)']
    Capture Page Screenshot

Then Le motif de forçage du prix Forcage BL (FBL) est sélectionné
    Wait Until Element Is Visible    ${FIELD-ID4}    timeout=120s

    # Vérifier que le champ a une valeur non vide
    ${field_value}=    Get Value    ${FIELD-ID4}
    Should Not Be Empty    ${field_value}    msg=Le champ motif de forçage du prix a une valeur 'Forcage BL (FBL)' '.
    Log    Le champ type d'ordre de livraison a une valeur 'Forcage BL (FBL)'.

When L'utilisateur clique sur "Enregistrer"
    Wait Until Element Is Visible          Xpath=/html/body/div[2]/div[1]/div[10]/div[4]/button[8]
    Click Element    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/button[8]
    Sleep    5s

Then Les détails du bon de livraison s'affichent, avec le prix correctement appliqué
    Wait Until Page Contains    Détail(s) de bon de livraison
    Log     La page contient bien "Détail(s) de bon de livraison avec le prix correctement appliqué"

And l'utilisateur ferme le 1er pop up
    Wait Until Element Is Visible   xpath=/html/body/div[2]/div[1]/div[9]/div[1]/table/tbody/tr/td[3]/div/span[5]
    Click Element    xpath=/html/body/div[2]/div[1]/div[9]/div[1]/table/tbody/tr/td[3]/div/span[5]
    Sleep    3s
And l'utilisateur ferme le 2eme pop up
    Wait Until Element Is Visible   xpath=/html/body/div[2]/div[1]/div[8]/div[1]/table/tbody/tr/td[3]/div/span[5]
    Click Element    xpath=/html/body/div[2]/div[1]/div[8]/div[1]/table/tbody/tr/td[3]/div/span[5]
    Sleep    3s