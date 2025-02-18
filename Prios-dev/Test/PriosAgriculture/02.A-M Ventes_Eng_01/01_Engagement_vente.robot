*** Settings ***
Library    SeleniumLibrary    run_on_failure=Capture Page Screenshot
Library    SeleniumLibrary
Library    DateTime

*** Variables ***
@{OPTIONS3}    Engagements    Editions    Listes    Solde    Edition proforma    Valorisation engagements    Duplication engagemt/période    Rapports
${CALENDRIER_BOUTON}    xpath=/html/body/div[2]/div[1]/div[7]/div[4]/button[1]
${PRECEDENT_BOUTON}     xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div/div[1]/table/thead/tr[1]/th[1]
${MOIS_TITRE}     xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div/div[1]/table/thead/tr[1]/th[2]/span[1]/span/span/span[2]
${ANNEE_TITRE}    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div/div[1]/table/thead/tr[1]/th[2]/span[2]/span/span/span[2]
${JOUR_FORMAT}    //a[text()='%s']

*** Keywords ***
When L'utilisateur choisit "Engagements" dans la deuxième colonne
    [Documentation]    Sélectionne l'option "Ordres de livraison" sur la page.
    Execute JavaScript    document.evaluate("(//*[contains(text(), 'Engagements')])[1]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    Sleep    1s
    Execute JavaScript    document.evaluate("(//*[contains(text(), 'Engagements')])[1]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()

    Sleep    10s

Les fonctions suivantes s'affichent dans la troisième colonne : "Engagements", "Editions", "Listes", "Solde", "Edition proforma", "Valorisation engagements", "Duplication engagement/période", "Rapports"
    FOR    ${option3}    IN    @{OPTIONS3}
        Log    Vérification de l'option : ${option3}

        # Faire défiler l'option dans la vue si nécessaire
        Execute JavaScript    document.evaluate("//*[contains(text(), '${option3}')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);

        # Attendre que l'option soit visible après le défilement
        Wait Until Element Is Visible    xpath=//*[contains(text(), '${option3}')]    timeout=30s

        # Vérifier que l'option est présente
        ${element_found} =    Execute JavaScript    return document.evaluate("//*[contains(text(), '${option3}')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
        Run Keyword If    '${element_found}' != 'None'    Log    Option ${option3} trouvée.
        Run Keyword If    '${element_found}' == 'None'    Fail    Option ${option3} non trouvée.
    END

When L'utilisateur sélectionne "Engagements" dans la troisième colonne
    [Documentation]    Sélectionne l'option "Ordres de livraison" sur la page.
    Execute JavaScript    document.evaluate("(//*[contains(text(), 'Engagements')])[2]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    Sleep    1s
    Execute JavaScript    document.evaluate("(//*[contains(text(), 'Engagements')])[2]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()
    Sleep    10s
Then L'utilisateur est redirigé vers un formulaire contenant une liste d'engagements vide
    Wait Until Page Contains    Engagements de ventes - Sté PRIOS - Etablissement CARQUEFOU    30s
    Log  Engagements de ventes - Sté PRIOS - Etablissement CARQUEFOU


When L'utilisateur effectue une recherche avec les critères suivants :Date d'engagement à partir de, Date du jour - "3" moi,Soldés, Non soldés
    Click Element    ${CALENDRIER_BOUTON}  # Ouvrir le calendrier
    Sleep    10s

   ${date_jour}=    Get Current Date    time_zone=LOCAL
    ${date_jour_formatee}=    Convert Date    ${date_jour}    result_format=%Y-%m-%d
    ${timestamp_3mois}=    Add Time To Date    ${date_jour}    -90 days
    ${date_3mois_avant}=    Convert Date    ${timestamp_3mois}    result_format=%Y-%m-%d

    # Extraire les composants de la date
    ${annee}=    Convert Date    ${date_3mois_avant}    result_format=%Y
    ${mois}=    Convert Date    ${date_3mois_avant}    result_format=%m
    ${jour}=    Convert Date    ${date_3mois_avant}    result_format=%d

    # Ouvrir le calendrier
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[7]/div[4]/div[47]/fieldset/span[2]/div/input    timeout=10s
    Click Element    xpath=/html/body/div[2]/div[1]/div[7]/div[4]/div[47]/fieldset/span[2]/div/input

    # Navigation et sélection de la date
    Wait Until Element Is Visible    xpath=//span[@class='calendar-title']    timeout=10s
    Click Element    xpath=//span[@class='calendar-title']
    Click Element    xpath=//td[text()='${annee}']
    Click Element    xpath=//td[text()='${mois}']
    Click Element    xpath=//td[text()='${jour}']

    # Fermer le calendrier
    Press Keys    None    RETURN

    Sleep    3s
# Wait for any overlay to disappear
    Wait Until Element Is Not Visible    css=.dijitDialogDisabledMask    timeout=10s

    # Wait for element to be clickable
    Wait Until Element Is Enabled    xpath=/html/body/div[2]/div[1]/div[7]/div[4]/div[47]/fieldset/span[2]/div/input    timeout=10s

    # Execute JavaScript click for reliability
    Execute JavaScript    document.querySelector('input[name="a_zk7_id-Radio"]').click()

When L'utilisateur clique sur le bouton '+' ou clique droit dans la liste et sélectionne "Nouveau"
   [Documentation]    Sélectionne l'option "le bouton +" sur la page.
    Wait Until Element Is Visible    xpath=//img[contains(@class, 'a-image') and contains(@src, 'CB8CF15EBC54179FBC57E708D9C763D9')]    timeout=30s

    Execute JavaScript    document.evaluate("//img[contains(@class, 'a-image') and contains(@src, 'CB8CF15EBC54179FBC57E708D9C763D9')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    Sleep    10s
    Click Element    xpath=//img[contains(@class, 'a-image') and contains(@src, 'CB8CF15EBC54179FBC57E708D9C763D9')]
    Sleep    30s

Then L'utilisateur est redirigé vers l'entête engagement avec le formulaire
    Wait Until Page Contains    Engagement   30s
    Log  Engagement
    Wait Until Page Contains    Numéro
    Log    Numéro

When L'utilisateur sélectionne type engagement dans la liste déroulante depuis la section 'Informations générales puis Classification'
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div[1]/div/div[4]/div[1]    timeout=30s
    Click Element    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div[1]/div/div[4]/div[1]

    Wait Until Element Is Visible    xpath=(//input[@value='▼ '])[6]  100s
    Click Element                    xpath=(//input[@value='▼ '])[6]
    Sleep    30s

    # Attendre que la liste déroulante soit visible
    Wait Until Element Is Visible    xpath=//div[@class='dijitPopup dijitComboBoxMenuPopup' and not(contains(@style, 'display: none'))]    120s

# Cliquer sur l'élément
    Click Element    xpath=//div[@class='a-combosimplemenuitem'][normalize-space(text())='AB_Contrat son (AB2)']
    Capture Page Screenshot