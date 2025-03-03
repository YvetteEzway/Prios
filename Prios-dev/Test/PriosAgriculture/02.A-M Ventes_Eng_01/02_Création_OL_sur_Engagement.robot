*** Settings ***
Library    SeleniumLibrary    run_on_failure=Capture Page Screenshot
Library    DateTime


*** Variables ***

*** Keywords ***
Given L'utilisateur se trouve sur la page "Plateformes métier"
    [Documentation]    Vérifie que l'utilisateur est sur la page "Plateformes métier".
    Wait Until Page Contains    Plateformes    30s
    Capture Page Screenshot

When L'utilisateur sélectionne l'option "PRIOS Agriculture" dans la section "Plateformes métier"
    [Documentation]    Sélectionne l'option "PRIOS Agriculture" sur la page.
    Wait Until Element Is Visible    xpath=/html/body/pr-root/pr-main/div/pr-grid-main/div/div/div/div[1]/div[2]/div/div/div/div[1]/div[3]    10s
    Click Element    xpath=/html/body/pr-root/pr-main/div/pr-grid-main/div/div/div/div[1]/div[2]/div/div/div/div[1]/div[3]
    Capture Page Screenshot

Then Il est redirigé vers une nouvelle page avec les menus de navigation
    [Documentation]    Vérifie que la nouvelle page contient le texte spécifique pour confirmer la redirection.
    Wait Until Page Contains    Prios    10s
    Capture Page Screenshot

Then Les menus de navigation affichent :

    [Documentation]    Vérifie que les 8 options spécifiées sont présentes dans le menu.
    # Ouvrir l'onglet contenant les options
    ${handles} =    Get Window Handles
    Switch Window    ${handles}[-1]
    Sleep    10s
    Capture Page Screenshot


When L'utilisateur clique sur "PRIOS A-M Ventes"
    [Documentation]    Sélectionne l'option "PRIOS A-M Ventes" sur la page.
    Execute JavaScript    document.evaluate("//*[contains(text(), 'PRIOS A-M Ventes')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);

    Wait Until Element Is Visible    xpath=//*[contains(text(), 'PRIOS A-M Ventes')]    30s
    Click Element    xpath=//*[contains(text(), 'PRIOS A-M Ventes')]

    Sleep    5s
    Capture Page Screenshot

When L'utilisateur sélectionne "Ordres de livraison" dans la deuxième colonne

    [Documentation]    Sélectionne l'option "Ordres de livraison" sur la page.
    Execute JavaScript    document.evaluate("(//*[contains(text(), 'Ordres de livraison')])[1]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    Sleep    1s
    Execute JavaScript    document.evaluate("(//*[contains(text(), 'Ordres de livraison')])[1]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()

    Sleep    5s
    Capture Page Screenshot

When L'utilisateur sélectionne Ordres de livraison dans la troisième colonne

    [Documentation]    Sélectionne l'option "Ordres de livraison troisième colonne " sur la page.
    Execute JavaScript    document.evaluate("(//*[contains(text(), 'Ordres de livraison')])[2]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    Sleep    1s
    Execute JavaScript    document.evaluate("(//*[contains(text(), 'Ordres de livraison')])[2]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()

    Sleep    5s
    Capture Page Screenshot

Then il est redirigé vers un formulaire affichant une liste vide d'ordres de livraison


