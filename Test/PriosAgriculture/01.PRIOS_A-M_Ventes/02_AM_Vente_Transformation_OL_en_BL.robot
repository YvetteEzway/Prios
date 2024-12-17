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
    Sleep    30s
    Click Element    xpath=//img[contains(@class, 'a-image') and contains(@src, '540900E90F2F7123BB05B76317E76008')]
    Sleep    60s


When l'utilisateur double-clique sur la ligne
    Sleep    2s
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
    Sleep    2s

Then Le formulaire d'ordre de livraison est affiché avec les champs initialisés: Preneur d'ordre,Type d'ordre de livraison, Site,Date de livraison souhait,Date de départ,Date de l'ordre de livraison, Moment
 # Attendre que le parent de l'élément soit visible
    Wait Until Element Is Visible    ${PARENT_XPATH}    timeout=20s

    # Attendre que l'élément soit visible
    Wait Until Element Is Visible    ${FIELD_ID}    timeout=20s

    # Vérifier que le champ a une valeur non vide
    ${field_value}=    Get Value    ${FIELD_ID}
    Should Not Be Empty    ${field_value}    msg=Le champ a une valeur.
    Log    Le champ Preneur d'ordre a une valeur.
    # Vérifier que le champ est grisé (readonly)
    ${readonly}=    Get Element Attribute    ${FIELD_ID}    readonly
    Should Be Equal As Strings    ${readonly}    true    msg=Le champ est en lecture seule.
    Log   Le champ est grisé et en mode lecture seule.


    # Attendre que l'élément soit visible
    Wait Until Element Is Visible    ${FIELD_ID2}    timeout=30s

    # Obtenir la valeur du champ
    ${field_value1}=    Get Value   ${FIELD_ID2}
    Should Not Be Empty    ${field_value1}    msg=Le champ a une valeur.
    Log    Le champ a une valeur.

    # Vérifier que le champ est grisé (readonly)
    ${readonly}=    Get Element Attribute    ${FIELD_ID2}    readonly
    Should Be Equal As Strings    ${readonly}    true    msg=Le champ est en lecture seule.
    Log   Le champ est grisé et en mode lecture seule.

     Wait Until Element Is Visible    ${FIELD-ID4}    timeout=100s

    # Vérifier que le champ a une valeur non vide
    ${field_value}=    Get Value    ${FIELD-ID4}
    Should Not Be Empty    ${field_value}    msg=Le champ type d'ordre de livraison a une valeur 'OL Standard (STD)' '.
    Log    Le champ type d'ordre de livraison a une valeur 'OL Standard (STD)'.

    Wait Until Element Is Visible    ${FIELD-ID5}    timeout=20s

    # Vérifier que le champ a une valeur non vide
    ${field_value}=    Get Value    ${FIELD-ID5}
    Should Not Be Empty    ${field_value}    msg=Le champ Site a une valeur 'Z COREAL (ZCO) '.
    Log    Le champ Site a une valeur 'Z COREAL (ZCO)'.

 # Attendre que l'élément soit visible
    Wait Until Element Is Visible    ${FIELD-ID6}     timeout=20s

    # Vérifier que le champ a une valeur non vide
    ${field_value}=    Get Value    ${FIELD-ID6}
    Should Not Be Empty    ${field_value}    msg=Le champ a une valeur.
    Log    Le champ Date de livraison souhait a une valeur.


    Wait Until Element Is Visible    ${FIELD-ID7}     timeout=20s

    # Vérifier que le champ a une valeur non vide
    ${field_value}=    Get Value    ${FIELD-ID7}
    Should Not Be Empty    ${field_value}    msg=Le champ a une valeur.
    Log    Le champ Date de départ a une valeur.

    Wait Until Element Is Visible    ${FIELD-ID8}     timeout=20s

    # Vérifier que le champ a une valeur non vide
    ${field_value}=    Get Value    ${FIELD-ID8}
    Should Not Be Empty    ${field_value}    msg=Le champ a une valeur.
    Log    Le champ Date de l'ordre de livraison a une valeur.

     Wait Until Element Is Visible    ${FIELD-ID9}     timeout=20s

    # Vérifier que le champ a une valeur non vide
    ${field_value}=    Get Value    ${FIELD-ID9}
    Should Not Be Empty    ${field_value}    msg=Le champ a une valeur.
    Log    Le champ Moment a une valeur.

When L'utilisateur clique sur "Détails" puis continue
    Wait Until Element Is Visible   xpath=/html/body/div[2]/div[1]/div[8]/div[4]/button[11]
    Click Element    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/button[11]
    Sleep    10s
