*** Settings ***
Library    SeleniumLibrary    run_on_failure=Capture Page Screenshot
Library    SeleniumLibrary
Library    OperatingSystem
Library    RequestsLibrary
Library    BuiltIn
Library    String
Library    DateTime


*** Variables ***
${FIELD-ID4}        15/01/2025
${CALENDAR_BUTTON}     xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div[1]/div/button[1]/div
${DATE_FORMAT}      %d
${DATE_FORMAT}        %d/%m/%Y
${FIELD_XPATH}    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div[1]/div/div[3]/div/input
${CALENDAR_BUTTON2}     xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div[1]/div/button[4]/div
${FIELD_XPATH2}    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div[1]/div/div[18]/div/input
${BL_NUMBER}        2501000009
${BL_NUMBER2}       xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div[1]/div/div[88]/div/input
${TABLE_ROW_XPATH}      xpath=/html/body/div[2]/div[1]/div[7]/div[4]/div[1]/div[3]/div/div/div[39]/div[2]/div/div[2]/table/tr
${MENU_OPTION_XPATH}    xpath=//ul[@class='context-menu']//li[contains(text(), 'Simulation')]


*** Keywords ***

And L'utilisateur se trouve sur le menu principal de l'application

    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[7]/div[1]/table/tbody/tr/td[3]/div/span[5]      10s
    Click Element    xpath=/html/body/div[2]/div[1]/div[7]/div[1]/table/tbody/tr/td[3]/div/span[5]
    Sleep    2s
When L'utilisateur clique sur "PRIOS A-M Ventes"
    [Documentation]    Sélectionne l'option "PRIOS A-M Ventes" sur la page.
    Execute JavaScript    document.evaluate("//*[contains(text(), 'PRIOS A-M Ventes')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);

    Wait Until Element Is Visible    xpath=//*[contains(text(), 'PRIOS A-M Ventes')]    20s
    Click Element    xpath=//*[contains(text(), 'PRIOS A-M Ventes')]

    Sleep    10s
When L'utilisateur choisit "Facturation" dans la deuxième colonne
    [Documentation]    Sélectionne l'option "Facturation" sur la page.
    Execute JavaScript    document.evaluate("//*[contains(text(), 'Facturation')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);

    Wait Until Element Is Visible    xpath=//*[contains(text(), 'Facturation')]    20s
    Click Element    xpath=//*[contains(text(), 'Facturation')]
    Sleep    10s
When L'utilisateur sélectionne "Traitement de factures" dans la troisième colonne
    [Documentation]    Sélectionne l'option "Traitement de factures" sur la page.
    Wait Until Element Is Visible    xpath=//*[contains(text(), 'Traitement factures')]    10s
    Click Element    xpath=//*[contains(text(), 'Traitement factures')]
    Sleep    3s

Then L'utilisateur est redirigé vers un formulaire contenant une liste des traitements de factures de vente
    [Documentation]    Vérifie que la nouvelle page contient le texte spécifique pour confirmer la redirection.
    Page Should Contain    Traitement(s) de facturation de vente
    Log     La liste des "Traitement(s) de facturation de vente" est bien présent sur la page    INFO

When L'utilisateur clique sur le bouton '+'
    [Documentation]    Sélectionne l'option "le bouton +" sur la page.
    Wait Until Element Is Visible    xpath=//img[contains(@class, 'a-image') and contains(@src, 'CB8CF15EBC54179FBC57E708D9C763D9')]    timeout=30s

    Execute JavaScript    document.evaluate("//img[contains(@class, 'a-image') and contains(@src, 'CB8CF15EBC54179FBC57E708D9C763D9')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    Sleep    10s
    Click Element    xpath=//img[contains(@class, 'a-image') and contains(@src, 'CB8CF15EBC54179FBC57E708D9C763D9')]
    Sleep    20s
Then L'utilisateur est redirigé vers un formulaire pour ajouter un nouveau traitement de facturation.
    [Documentation]    Vérifie que la nouvelle page contient Traitement de facturation.
    Page Should Contain    Traitement de facturation
    Log     La page "Traitement de facturation" est bien présent sur la page    INFO

when L'utilisateur saisit la date du jour dans le champ 'Date de facturation'

    ${current_day} =    Get Current Date    result_format=%d
    ${current_day} =    Evaluate    str(int('${current_day}'))    # Supprimer le zéro devant si nécessaire
    Log    Date du jour : ${current_day}

# 1️⃣ Ouvrir le calendrier
    Click Element    ${CALENDAR_BUTTON}
    Sleep    3s  # Laisser le temps au calendrier de s'afficher

# 2️⃣ Vérifier que le calendrier est bien ouvert avant d'aller plus loin
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'dijitCalendarContainer')]    timeout=10s
    Log    Le calendrier est bien affiché

# 3️⃣ Définir le XPath de la date
    ${date_xpath} =  Set Variable  //span[contains(@class, 'dijitCalendarDateLabel') and normalize-space(text())='${current_day}']
    Log    XPath généré : ${date_xpath}

# 4️⃣ Vérifier que l'élément est bien présent dans le DOM avant d'aller plus loin
    ${is_present} =  Run Keyword And Return Status    Page Should Contain Element    ${date_xpath}
    Log    L'élément est-il présent dans le DOM ? ${is_present}

# 5️⃣ Si l'élément n'est pas immédiatement visible, scroller jusqu'à lui
    Run Keyword If  '${is_present}' == 'True'
    ...  Execute JavaScript    return document.evaluate("${date_xpath}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    Sleep    5s

# 6️⃣ Attendre que l'élément soit visible
    Wait Until Element Is Visible    ${date_xpath}    timeout=20s
    Wait Until Element Is Enabled    ${date_xpath}    timeout=10s

# 7️⃣ Double-cliquer sur la date
    Double Click Element    ${date_xpath}
    Sleep    10s

    Capture Page Screenshot     debug_calendar_2.png

Then La date du jour s'affiche dans le champ 'Date de facturation'
    ${current_date}=    Get Current Date    result_format=%d/%m/%Y
    Log    Date actuelle : ${current_date}

# Extraire le jour, mois, et année
    ${current_day} =    Evaluate    str(int('${current_date}[0:2]'))  # Jour sans zéro
    ${current_month} =  Evaluate    "%02d" % int('${current_date}[3:5]')  # Garde le mois avec zéro
    ${current_year} =   Evaluate    str('${current_date}[6:10]')  # Année complète


# Recomposer la date avec jour, mois, et année
    ${current_date_no_zero} =    Set Variable    ${current_day}/${current_month}/${current_year}
    Log    Date actuelle avec jour, mois et année : ${current_date_no_zero}

# Synchronisation
    Wait Until Element Is Visible    ${FIELD_XPATH}    timeout=10s
    Wait Until Element Is Enabled    ${FIELD_XPATH}    timeout=10s
    Sleep    2s

# Récupération de la valeur affichée
    ${displayed_date}=    Get Value    ${FIELD_XPATH}
    Log    Date affichée dans le champ : ${displayed_date}

# Vérification - utiliser la date avec jour, mois et année pour la comparaison
    Should Be Equal As Strings    ${displayed_date}    ${current_date_no_zero}
    Capture Page Screenshot    datefacture1.png

When L'utilisateur saisit la date du jour dans le champ 'Fin d'extraction des mouvements'
    ${current_day} =    Get Current Date    result_format=%d
    ${current_day} =    Evaluate    str(int('${current_day}'))    # Supprimer le zéro devant si nécessaire
    Log    Date du jour : ${current_day}
# Ouvrir le calendrier
    Click Element    ${CALENDAR_BUTTON2}
    Sleep    3s
    ${date_xpath} =  Set Variable  //span[@class='dijitCalendarDateLabel' and text()='${current_day}']

    Wait Until Element Is Visible    ${date_xpath}    timeout=10s
    Wait Until Element Is Enabled    ${date_xpath}    timeout=10s
    Sleep    2s

    # Faire défiler jusqu'à l'élément
    Execute JavaScript    return document.evaluate("${date_xpath}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);

    # Double-cliquer sur la date
    Double Click Element    ${date_xpath}
    Sleep    10s
    Capture Page Screenshot    datefacture2.png


Then La date de fin d'extraction des mouvements est correctement saisie
     ${current_date}=    Get Current Date    result_format=%d/%m/%Y
    Log    Date actuelle : ${current_date}

# Extraire le jour, mois, et année
    ${current_day} =    Evaluate    str(int('${current_date}[0:2]'))  # Jour sans zéro
    ${current_month} =  Evaluate    "%02d" % int('${current_date}[3:5]')  # Garde le mois avec zéro
    ${current_year} =   Evaluate    str('${current_date}[6:10]')  # Année complète


# Recomposer la date avec jour, mois, et année
    ${current_date_no_zero} =    Set Variable    ${current_day}/${current_month}/${current_year}
    Log    Date actuelle avec jour, mois et année : ${current_date_no_zero}

# Synchronisation
    Wait Until Element Is Visible    ${FIELD_XPATH2}    timeout=10s
    Wait Until Element Is Enabled    ${FIELD_XPATH2}    timeout=10s
    Sleep    2s

# Récupération de la valeur affichée
    ${displayed_date}=    Get Value    ${FIELD_XPATH2}
    Log    Date affichée dans le champ : ${displayed_date}

# Vérification - utiliser la date avec jour, mois et année pour la comparaison
    Should Be Equal As Strings    ${displayed_date}    ${current_date_no_zero}
    Capture Page Screenshot    datefacture1.png


When L'utilisateur saisit le numéro du BL dans le champ 'Bon de livraison'
    #cliquer sur le loupe
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div[1]/div/button[14]      timeout=30s

    Execute JavaScript    document.evaluate("/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div[1]/div/button[14]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    Sleep    1s
    Click Element    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div[1]/div/button[14]
    Sleep    3s
    #cliquer sur la 1er cellule de la 1er colonne bon de livraison
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div/div/div[2]/div[1]/table/tr/th[1]
    Execute JavaScript    document.evaluate("/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div/div/div[2]/div[1]/table/tr/th[1]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    Sleep    1s
    Click Element    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div/div/div[2]/div[1]/table/tr/th[1]
    Sleep    5s
    #cliquer sur le 1er bon de livraison
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div/div/div[2]/div[2]/div/div[2]/table/tr[1]    timeout=20s
    Click Element    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div/div/div[2]/div[2]/div/div[2]/table/tr[1]
    Execute Javascript
    ...    var element = document.evaluate("/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div/div/div[2]/div[2]/div/div[2]/table/tr[1]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
    ...    var dblClickEvent = new MouseEvent('dblclick', {
    ...        'view': window,
    ...        'bubbles': true,
    ...        'cancelable': true,
    ...        'detail': 2
    ...    });
    ...    element.focus();
    ...    element.dispatchEvent(dblClickEvent);
    Sleep    5s

Then Le numéro du BL est correctement ajouté dans le champ 'Bon de livraison'
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div[1]/div/div[88]/div/input
    # Attendre que l'élément soit visible
    Wait Until Element Is Visible    ${BL_NUMBER2}    timeout=20s

    # Vérifier que le champ a une valeur non vide
    ${field_value}=    Get Value    ${BL_NUMBER2}
    Should Not Be Empty    ${field_value}    msg=Le champ a une valeur.
    Log    Le numéro du BL est correctement ajouté dans le champ 'Bon de livraison'.
    Sleep    1s
Then L'utilisateur clique sur "Enregistrer"
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/button[7]
    Click Element    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/button[7]
    Sleep    10s

Then Un traitement de facturation de vente est ajouté à la liste des traitements de factures
    [Documentation]    Vérifie que la nouvelle page contient Traitement de facturation.
    Page Should Contain    Traitement(s) de facturation de vente
    Log     La page "Traitement(s) de facturation de vente" est ajouté à la liste des traitements de factures    INFO


When L'utilisateur fait un clic droit sur le traitement de facture dans la liste créé précédemment, puis clique sur "Simulation"
    Wait Until Element Is Visible  ${TABLE_ROW_XPATH}  timeout=10s
    Open Context Menu  ${TABLE_ROW_XPATH}
    Log     L'utilisateur a fait un clic droit sur le traitement de facturedans la liste.

    #Execute JavaScript  let element = document.evaluate("//ul[@class='context-menu']//li[normalize-space(text())='Simulation'][1]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;  if (element) {  element.click();} else {console.log("Element not found");}
    Sleep    5s
 # Afficher tous les menus disponibles pour debug
    # Affichons la structure exacte du menu
    ${menu_item}=    Execute JavaScript
    ...    return Array.from(document.getElementsByClassName('dijitMenuItemLabel')).find(el => el.textContent.trim() === 'Simulation');

    Execute JavaScript
    ...    arguments[0].click();
    ...    ARGUMENTS    ${menu_item}

    Sleep    10s
Then Une popup de demande de confirmation du lancement de la simulation s'affiche, et l'utilisateur Clique sur ok pour lancer le traitement de simulation.
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[8]/div[2]/div[2]/div/button[1]     timeout=10s
    Click Element    xpath=/html/body/div[2]/div[1]/div[8]/div[2]/div[2]/div/button[1]

    Sleep    10s

And La liste des BL traités par la simulation s'affiche en PDF dans un autre onglet
     ${handles}=    Get Window Handles

    # Switch to the new tab (last handle in the list)
    Switch Window    ${handles}[-1]

    # Attendre que le PDF s'affiche
    Wait Until Element Is Visible    //embed[@type='application/pdf']    timeout=10s
    Capture Page Screenshot    pdf_screenshot.png
    Close Window

# Revenir à l'onglet principal
    Switch Window    ${handles}[1]
    log  L'utilisateur est redirigé vers un formulaire contenant une liste des 'Ordres de livraison'
    Sleep    3s
