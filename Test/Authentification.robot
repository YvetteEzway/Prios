*** Settings ***
Library    squash_tf.TFParamService
Library    SeleniumLibrary    run_on_failure=Capture Page Screenshot
Library    OperatingSystem

*** Variables ***
${URL}          https://portail-0015.cloud-prios.fr/
${USERNAME}     prios.qa1@prios.fr
${PASSWORD}     Ezw@171M

*** Test Cases ***
Open Browser And Go To Page
    Open Browser    ${URL}    Chrome  keep_open=True
    Maximize Browser Window
    Wait Until Element Is Visible    xpath=//*[@id="i0116"]
    Input Text    xpath=//*[@id="i0116"]    ${USERNAME}
    Click Element   xpath=//*[@id="idSIButton9"]
    Wait Until Element Is Visible    xpath=//*[@id="i0118"]
    Input Text      xpath=//*[@id="i0118"]     ${PASSWORD}
    Click Element    xpath=//*[@id="idSIButton9"]

    Sleep    10s
    Click Element    xpath=/html/body/pr-root/pr-main/div/pr-grid-main/div/div/div/div[1]/div[2]/div/div/div/div[1]/div[3]
    ${handles} =    Get Window Handles
    Switch Window    ${handles}[-1]

    # Ajouter un délai pour s'assurer que la page est complètement chargée
    Sleep    1000s

    # Vérifier du texte visible sur la page
    Page Should Contain    PRIOS A-M Ventes

    # Faire défiler jusqu'à l'élément
    Scroll Element Into View    xpath=//*[contains(text(), 'PRIOS A-M Ventes')]

    # Attendre que l'élément soit visible
    Wait Until Element Is Visible    xpath=//*[contains(text(), 'PRIOS A-M Ventes')]

    # Utiliser JavaScript pour cliquer sur l'élément
    Execute JavaScript    document.evaluate("//*[contains(text(), 'PRIOS A-M Ventes')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click();

    # Prendre une capture d'écran de la page après le clic
    Capture Page Screenshot    clicked_element_screenshot.png

    # Afficher un message de réussite
    Log    Capture d'écran prise et enregistrée en tant que clicked_element_screenshot.png

    # Vérifier du texte visible sur la nouvelle page
    Page Should Contain    Ordres de livraison

    # Faire défiler jusqu'à l'élément "Ordres de livraison"
    Scroll Element Into View    xpath=//*[contains(text(), 'Ordres de livraison')]

    # Attendre que l'élément soit visible
    Wait Until Element Is Visible    xpath=//*[contains(text(), 'Ordres de livraison')]

    # Utiliser JavaScript pour cliquer sur l'élément
    Execute JavaScript    document.evaluate("//*[contains(text(), 'Ordres de livraison')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click();

    # Prendre une capture d'écran de la page après le clic
    Capture Page Screenshot    selenium-screenshot-4.png

    # Afficher un message de réussite
    Log    Capture d'écran prise et enregistrée en tant que selenium-screenshot-4.png
