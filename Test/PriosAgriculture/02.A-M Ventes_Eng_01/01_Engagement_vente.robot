*** Settings ***
Library    SeleniumLibrary    run_on_failure=Capture Page Screenshot
Library    SeleniumLibrary

*** Variables ***
@{OPTIONS}    Engagements    Editions    Listes    Solde    Edition proforma    Valorisation engagements    Duplication engagemt/période    PRIOS A-M Prix de revient


*** Keywords ***
When L'utilisateur choisit "Engagements" dans la deuxième colonne
    [Documentation]    Sélectionne l'option "Ordres de livraison" sur la page.
    Execute JavaScript    document.evaluate("(//*[contains(text(), 'Engagements')])[1]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    Sleep    1s
    Execute JavaScript    document.evaluate("(//*[contains(text(), 'Engagements')])[1]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()

    Sleep    10s

Les fonctions suivantes s'affichent dans la troisième colonne : "Engagements", "Editions", "Listes", "Solde", "Edition proforma", "Valorisation engagements", "Duplication engagement/période", "Rapports"
    FOR    ${option}    IN    @{OPTIONS}
        Log    Vérification de l'option : ${option}

        # Faire défiler l'option dans la vue si nécessaire
        Execute JavaScript    document.evaluate("//*[contains(text(), '${option}')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);

        # Attendre que l'option soit visible après le défilement
        Wait Until Element Is Visible    xpath=//*[contains(text(), '${option}')]    timeout=30s

        # Vérifier que l'option est présente
        ${element_found} =    Execute JavaScript    return document.evaluate("//*[contains(text(), '${option}')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
        Run Keyword If    '${element_found}' != 'None'    Log    Option ${option} trouvée.
        Run Keyword If    '${element_found}' == 'None'    Fail    Option ${option} non trouvée.
    END
When L'utilisateur sélectionne "Engagements" dans la troisième colonne
