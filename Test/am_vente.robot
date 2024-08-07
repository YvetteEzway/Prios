*** Settings ***
Library    SeleniumLibrary    run_on_failure=Capture Page Screenshot
Library    OperatingSystem
Library    RequestsLibrary


*** Variables ***
${ORDRES_LIVRAISON_BUTTON}    xpath=(//*[contains(text(), 'Ordres de livraison')])[1]
${ORDRES_LIVRAISON2_BUTTON}   xpath=(//*[contains(text(), 'Ordres de livraison')])[2]


*** Keywords ***
Navigate To PRIOS Ventes
    [Documentation]    Naviguer vers la section PRIOS A-M Ventes
    Sleep    10s
    Log    Navigating to PRIOS A-M Ventes
    Click Element    xpath=/html/body/pr-root/pr-main/div/pr-grid-main/div/div/div/div[1]/div[2]/div/div/div/div[1]/div[3]
    ${handles} =    Get Window Handles
    Switch Window    ${handles}[-1]
    Wait Until Element Is Visible    xpath=//*[contains(text(), 'PRIOS A-M Ventes')]    1000s
    Execute JavaScript    document.evaluate("//*[contains(text(), 'PRIOS A-M Ventes')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    Sleep    1s
    Execute JavaScript    document.evaluate("//*[contains(text(), 'PRIOS A-M Ventes')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()

Navigate To Ordres De Livraison
    [Documentation]    Naviguer vers la section Ordres de livraison
    Wait Until Element Is Visible    ${ORDRES_LIVRAISON_BUTTON}    1000s
    Log    Navigating to Ordres de livraison
    Execute JavaScript    document.evaluate("(//*[contains(text(), 'Ordres de livraison')])[1]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    Sleep    1s
    Execute JavaScript    document.evaluate("(//*[contains(text(), 'Ordres de livraison')])[1]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()

Navigate To Ordres De Livraison2
    [Documentation]    Naviguer vers la section Ordres de livraison 2 dans la troisième colonne
    Wait Until Element Is Visible    ${ORDRES_LIVRAISON2_BUTTON}    1000s
    Log    Navigating to Ordres de livraison 2 dans la troisième colonne
    Execute JavaScript    document.evaluate("(//*[contains(text(), 'Ordres de livraison')])[2]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    Sleep    1s
    Execute JavaScript    document.evaluate("(//*[contains(text(), 'Ordres de livraison')])[2]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()

