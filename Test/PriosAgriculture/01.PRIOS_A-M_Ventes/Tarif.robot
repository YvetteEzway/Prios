*** Settings ***
Library    SeleniumLibrary    run_on_failure=Capture Page Screenshot
Library    OperatingSystem

*** Variables ***
${TARIFS_VENTE}    xpath=//*[contains(text(), 'Tarifs vente')]
${TARIFS}    xpath=//*[contains(text(), 'Tarifs')]

*** Keywords ***
Navigate To PRIOS Ventes
    [Documentation]    Naviguer vers la section PRIOS A-M Ventes
    Sleep    10s
    Log    Navigating to PRIOS A-M Ventes
    Click Element    xpath=/html/body/pr-root/pr-main/div/pr-grid-main/div/div/div/div[1]/div[2]/div/div/div/div[1]/div[3]
    ${handles} =    Get Window Handles
    Switch Window    ${handles}[-1]
    Wait Until Element Is Visible    xpath=//*[contains(text(), 'PRIOS A-M Ventes')]    1000s
    Scroll Element Into View    xpath=//*[contains(text(), 'PRIOS A-M Ventes')]
    Execute JavaScript    document.evaluate("//*[contains(text(), 'PRIOS A-M Ventes')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()

Navigate To Tarifs ventes
    [Documentation]    Naviguer vers la section Tarifs vente
    Wait Until Element Is Visible    ${TARIFS_VENTE}    1000s
    Log    Navigating to Tarifs ventes
    Scroll Element Into View    ${TARIFS_VENTE}
    Click Element    ${TARIFS_VENTE}  # Utilisation de Click Element pour éviter les erreurs de JavaScript

Navigate To Tarifs
    [Documentation]    Naviguer vers la section Tarifs
    Wait Until Element Is Visible    ${TARIFS}    1000s
    Log    Navigating to Tarifs
    Scroll Element Into View    ${TARIFS}
    Click Element    ${TARIFS}    # Utilisation de Click Element pour éviter les erreurs de JavaScript
