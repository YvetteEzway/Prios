*** Settings ***
Library    SeleniumLibrary    run_on_failure=Capture Page Screenshot
Library    OperatingSystem
Library    RequestsLibrary
Library    BuiltIn
Library    String
Library    BuiltIn


*** Variables ***
${PARENT_XPATH}      xpath=//div[@class='dijitReset dijitInputField dijitInputContainer']
${FIELD_ID}          xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[3]/div/input
${FIELD_ID2}         xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[4]/div/input
${FIELD_ID3}          xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[7]
${FIELD-ID4}         xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[7]/div[3]/input
${FIELD-ID5}         xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[10]/div[3]/input
${FIELD-ID6}         xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[19]/div/input
${FIELD-ID7}         xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[31]/div/input
${FIELD-ID8}         xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[35]/div/input
${FIELD-ID9}         xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[50]/div[3]/input

*** Keywords ***

When L'utilisateur clique sur le bouton 'Loupe'
   [Documentation]    cliquer sur le loup
    Wait Until Element Is Visible    xpath=//img[contains(@class, 'a-image') and contains(@src, '540900E90F2F7123BB05B76317E76008')]      timeout=30s

    Execute JavaScript    document.evaluate("//img[contains(@class, 'a-image') and contains(@src, '540900E90F2F7123BB05B76317E76008')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    Sleep    10s
    Click Element    xpath=//img[contains(@class, 'a-image') and contains(@src, '540900E90F2F7123BB05B76317E76008')]
    Sleep    20s


When l'utilisateur double-clique sur la ligne
    Sleep    2s
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'dgrid-content')][last()]//table/tr/td    timeout=10s
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
    Sleep    2s

Then Le formulaire d'ordre de livraison est affiché avec les champs initialisés: Preneur d'ordre,Type d'ordre de livraison, Site,Date de livraison souhait,Date de départ,Date de l'ordre de livraison, Moment
 # Attendre que le parent de l'élément soit visible
    Wait Until Element Is Visible    ${PARENT_XPATH}    timeout=10s

    # Attendre que l'élément soit visible
    Wait Until Element Is Visible    ${FIELD_ID}    timeout=10s

    # Vérifier que le champ a une valeur non vide
    ${field_value}=    Get Value    ${FIELD_ID}
    Should Not Be Empty    ${field_value}    msg=Le champ a une valeur.
    Log    Le champ Preneur d'ordre a une valeur.
    # Vérifier que le champ est grisé (readonly)
    ${readonly}=    Get Element Attribute    ${FIELD_ID}    readonly
    Should Be Equal As Strings    ${readonly}    true    msg=Le champ est en lecture seule.
    Log   Le champ est grisé et en mode lecture seule.

    # Attendre que l'élément soit visible
    Wait Until Element Is Visible    ${FIELD_ID2}    timeout=10s

    # Obtenir la valeur du champ
    ${field_value1}=    Get Value   ${FIELD_ID2}
    Should Not Be Empty    ${field_value1}    msg=Le champ a une valeur.
    Log    Le champ a une valeur.

    # Vérifier que le champ est grisé (readonly)
    ${readonly}=    Get Element Attribute    ${FIELD_ID2}    readonly
    Should Be Equal As Strings    ${readonly}    true    msg=Le champ est en lecture seule.
    Log   Le champ est grisé et en mode lecture seule.

     Wait Until Element Is Visible    ${FIELD-ID4}    timeout=20s

    # Vérifier que le champ a une valeur non vide
    ${field_value}=    Get Value    ${FIELD-ID4}
    Should Not Be Empty    ${field_value}    msg=Le champ type d'ordre de livraison a une valeur 'OL Standard (STD)' '.
    Log    Le champ type d'ordre de livraison a une valeur 'OL Standard (STD)'.

    Wait Until Element Is Visible    ${FIELD-ID5}    timeout=5s

    # Vérifier que le champ a une valeur non vide
    ${field_value}=    Get Value    ${FIELD-ID5}
    Should Not Be Empty    ${field_value}    msg=Le champ Site a une valeur 'Z COREAL (ZCO) '.
    Log    Le champ Site a une valeur 'Z COREAL (ZCO)'.

 # Attendre que l'élément soit visible
    Wait Until Element Is Visible    ${FIELD-ID6}     timeout=5s

    # Vérifier que le champ a une valeur non vide
    ${field_value}=    Get Value    ${FIELD-ID6}
    Should Not Be Empty    ${field_value}    msg=Le champ a une valeur.
    Log    Le champ Date de livraison souhait a une valeur.

    Wait Until Element Is Visible    ${FIELD-ID7}     timeout=5s

    # Vérifier que le champ a une valeur non vide
    ${field_value}=    Get Value    ${FIELD-ID7}
    Should Not Be Empty    ${field_value}    msg=Le champ a une valeur.
    Log    Le champ Date de départ a une valeur.

    Wait Until Element Is Visible    ${FIELD-ID8}     timeout=5s

    # Vérifier que le champ a une valeur non vide
    ${field_value}=    Get Value    ${FIELD-ID8}
    Should Not Be Empty    ${field_value}    msg=Le champ a une valeur.
    Log    Le champ Date de l'ordre de livraison a une valeur.

     Wait Until Element Is Visible    ${FIELD-ID9}     timeout=5s

    # Vérifier que le champ a une valeur non vide
    ${field_value}=    Get Value    ${FIELD-ID9}
    Should Not Be Empty    ${field_value}    msg=Le champ a une valeur.
    Log    Le champ Moment a une valeur.

When L'utilisateur clique sur "Détails" puis continue
    Wait Until Element Is Visible   xpath=/html/body/div[2]/div[1]/div[8]/div[4]/button[11]
    Click Element    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/button[11]
    Sleep    5s
Then L'utilisateur est redirigé vers la fenêtre de détails de l'ordre de livraison
    [Documentation]
    Wait Until Page Contains    Détail(s) de l'ordre de livraison    timeout=10s
    Log    L'utilisateur est redirigé vers la fenêtre de détails de l'ordre de livraison.

When L'utilisateur clique sur "Validation Particulière"
    Wait Until Element Is Visible   xpath=/html/body/div[2]/div[1]/div[9]/div[4]/button[10]
    Click Element    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/button[10]
    Sleep    2s

Then Un pop-up de validation particulière s'affiche avec les cases à cocher:
    [Documentation]    Vérification de plusieurs éléments sur la page
    Wait Until Page Contains    En attente    timeout=5s
    Wait Until Page Contains    En attente de validation du responsable    timeout=10s
    Wait Until Page Contains    En attente d'ordonnance    timeout=10s
    Wait Until Page Contains    En attente pour cause de litige    timeout=5s
    Wait Until Page Contains    Validée et BL généré    timeout=5s
    Log    L'utilisateur est redirigé vers la fenêtre de détails de l'ordre de livraison.
    Log    Les cases à cocher suivants ont été vérifiés avec succès:
    Log    - En attente
    Log    - En attente de validation du responsable
    Log    - En attente d'ordonnance
    Log    - En attente pour cause de litige
    Log    - Validée et BL généré

When L'utilisateur coche la case 'Validée et BL généré'
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[9]/div/div[1]/input
    Click Element    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[9]/div/div[1]/input
    Sleep    2s


And l'utilisateur clique sur "Enregistrer"
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/button[6]    5s
    Click Element    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/button[6]

