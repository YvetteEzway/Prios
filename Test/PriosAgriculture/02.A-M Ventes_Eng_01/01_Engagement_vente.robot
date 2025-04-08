*** Settings ***
Library    SeleniumLibrary    run_on_failure=Capture Page Screenshot
Library    DateTime

*** Variables ***
@{OPTIONS3}    Engagements    Editions    Listes    Solde    Edition proforma    Valorisation engagements    Duplication engagemt/période    Rapports
${CALENDRIER_BOUTON}    xpath=/html/body/div[2]/div[1]/div[7]/div[4]/button[1]
${PRECEDENT_BOUTON}     xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div/div[1]/table/thead/tr[1]/th[1]
${MOIS_TITRE}     xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div/div[1]/table/thead/tr[1]/th[2]/span[1]/span/span/span[2]
${ANNEE_TITRE}    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div/div[1]/table/thead/tr[1]/th[2]/span[2]/span/span/span[2]
${JOUR_FORMAT}    //a[text()='%s']

${FIELD-ID4}    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div[1]/div/div[4]/div[3]/input
${FIELD-ID5}    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div[1]/div/div[12]/div/input

${CALENDAR_BUTTON2}  xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div[1]/div/button[2]/div
${FIELD_XPATH}       xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div[1]/div/div[15]/div/input
${NUMERO_ENGAGEMENT}     ${EMPTY}

*** Keywords ***
When L'utilisateur choisit "Engagements" dans la deuxième colonne
    [Documentation]    Sélectionne l'option "Ordres de livraison" sur la page.
    Execute JavaScript    document.evaluate("(//*[contains(text(), 'Engagements')])[1]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    Sleep    1s
    Execute JavaScript    document.evaluate("(//*[contains(text(), 'Engagements')])[1]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()

    Sleep    5s

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
    Sleep    3s
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
    Sleep    5s
    Click Element    xpath=//img[contains(@class, 'a-image') and contains(@src, 'CB8CF15EBC54179FBC57E708D9C763D9')]
    Sleep    10s

Then L'utilisateur est redirigé vers l'entête engagement avec le formulaire
    Wait Until Page Contains    Engagement   30s
    Log  Engagement
    Wait Until Page Contains    Numéro
    Log    Numéro

When L'utilisateur sélectionne type engagement dans la liste déroulante depuis la section 'Informations générales puis Classification'
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div[1]/div/div[4]/div[1]    timeout=30s
    Click Element    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div[1]/div/div[4]/div[1]

    Wait Until Element Is Visible    xpath=(//input[@value='▼ '])[6]  60s
    Click Element                    xpath=(//input[@value='▼ '])[6]

    # Attendre que la liste déroulante soit visible
    Wait Until Element Is Visible    xpath=//div[@class='dijitPopup dijitComboBoxMenuPopup' and not(contains(@style, 'display: none'))]    30s
    Click Element    xpath=//div[@class='a-combosimplemenuitem'][normalize-space(text())='AB_Contrat son (AB2)']
    Capture Page Screenshot
    Sleep    3s

Then Le type d'engagement est affiché dans la liste déroulante
    Execute JavaScript    document.evaluate("(//input[contains(@class, 'dijitInputInner')])[28]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    Wait Until Element Is Visible    xpath=(//input[contains(@class, 'dijitInputInner')])[28]    timeout=5s
    ${valeur_champ8}    Get Element Attribute    xpath=(//input[contains(@class, 'dijitInputInner')])[28]    value
    Log    Valeur du champ après visibilité : ${valeur_champ8}

When L'utilisateur saisit dans le champ "Engagé par" depuis la section 'Informations générales puis Compléments'
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div[1]/div/div[12]/div/input        timeout=3s
    Input Text    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div[1]/div/div[12]/div/input    ABBAYE61
    Sleep    2s
    Click Element    xpath=//body

Then La valeur "ABBAYE61" est affichée dans le champ "Engagé par"

    ${engagé_par}    Get Value    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div[1]/div/div[12]/div/input
    Should Not Be Empty    ${engagé_par}
    Sleep    2s

When L'utilisateur saisit la date du jour dans le champ "Date d'engagement" depuis la section 'Informations générales puis Compléments'

    Wait Until Element Is Visible    ${CALENDAR_BUTTON2}
    Click Element   ${CALENDAR_BUTTON2}
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[9]   timeout=5s
    Log To Console    Vérification de la présence de la date
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    xpath=//td[contains(@class, 'dijitCalendarDateTemplate')]//span[text()='1']   timeout=5s
    Capture Page Screenshot
    Double Click Element   xpath=//td[contains(@class, 'dijitCalendarDateTemplate')]//span[text()='1']
    Sleep    5s


Then La date du jour est affichée dans le champ "Date d'engagement"

    ${date_selection12}    Get Value    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div[1]/div/div[15]/div/input
    Should Not Be Empty    ${date_selection12}

When L'utilisateur clique sur le bouton "Enregistrer"
	 Execute JavaScript    document.body.style.zoom = '80%'
	 Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/button[7]
	 Click Element    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/button[7]
	 Sleep    5s

Then Un engagement est créé avec les détails
    Wait Until Page Contains    N° d'engagement
    Log  N° d'engagement
    #la valeur du numero d'engagement
    Wait Until Element Is Visible    xpath=(//div[contains(@class, 'a-outputfield')])[73]    timeout=5s
    ${valeur1}    Get Text    xpath=(//div[contains(@class, 'a-outputfield')])[73]
    Log    Valeur du du numéro d'engagement : ${valeur1}
    Set Suite Variable   ${NUMERO_ENGAGEMENT}    ${valeur1}

    Wait Until Page Contains    Engagé par
    Log  Engagé par

    Wait Until Page Contains    ABBAYE61
    Log  ABBAYE61

    Wait Until Page Contains    MDC_BISCUITERIE DE L ABBAYE
    Log  MDC_BISCUITERIE DE L ABBAYE

    Wait Until Page Contains   Statut ligne
    Log     Statut ligne

When L'utilisateur clique sur le bouton loupe à côté du champ 'Produit' dans la section 'Informations générales'
    Wait Until Element Is Visible            xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div[1]/div/button[1]    timeout=10s
    Click Button    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div[1]/div/button[1]

Then La liste de produits est affichée
    Wait Until Page Contains    Produits
    Log    La liste de produits est affichée

When L'utilisateur saisit le code du produit dans le champ 'Produit' et clique sur la loupe
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[8]/div/input     timeout=5s
    Input Text    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[8]/div/input    IMSFB1

    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/button[2]    timeout=5s
    Click Button    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/button[2]

Then Le produit correspondant est affiché dans la liste
    ${elements1}    Get WebElements    xpath=//div[@class='a-cell-inner']
    ${nombre1}    Get Length    ${elements1}
    Log    Nombre de cellules trouvées : ${nombre1}

When L'utilisateur double-clique sur le produit ou sélectionne la ligne de produit et clique sur 'Sélectionner'
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[2]/div[2]/div/div[2]/table/tbody/tr    timeout=20s
    Click Element    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[2]/div[2]/div/div[2]/table/tbody/tr
    Execute Javascript
    ...    var element = document.evaluate("/html/body/div[2]/div[1]/div[10]/div[4]/div[2]/div[2]/div/div[2]/table/tbody/tr", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
    ...    var dblClickEvent = new MouseEvent('dblclick', {
    ...        'view': window,
    ...        'bubbles': true,
    ...        'cancelable': true,
    ...        'detail': 2
    ...    });
    ...    element.focus();
    ...    element.dispatchEvent(dblClickEvent);
    Sleep    2s

Then Le détail de l'engagement est affiché avec le code de produit renseigné
    Wait Until Page Contains    Détail engagement ventes [C] - Sté PRIOS - Etablissement CARQUEFOU      timeout=30s
    Log    Détail engagement ventes est affichée

When L'utilisateur saisit la quantité engagée T dans le champ 'Engagée'
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div[1]/div/div[97]/div/input    timeout=1s
    Input Text    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div[1]/div/div[97]/div/input    10

Then La quantité engagée est affichée dans le champ
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div[1]/div/div[97]/div/input    timeout=10s
    ${engagé_par}=    Get Value    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div[1]/div/div[97]/div/input
    Log    Valeur sélectionnée : ${engagé_par}
    Sleep    2s

When L'utilisateur navigue vers l'onglet 'Livraison'
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[1]/div[4]/div/div[2]/span[2]   timeout=30s
    Click Element    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[1]/div[4]/div/div[2]/span[2]
    Sleep    2s

Then Le formulaire de livraison est affiché avec les détails partiellement remplis
    Wait Until Page Contains     Livraison
    Log    Le formulaire de livraison est affiché avec les détails partiellement remplis

When L'utilisateur saisit la date de période de livraison avec le début de mois et la fin de livraison = dernier jour du mois suivant
    #le periode de livraison
   ${current_day1} =    Get Current Date    result_format=%#d
    ${current_day} =    Evaluate    str(int('${current_day1}'))    # Supprimer le zéro devant si nécessaire
    Log    Date du jour : ${current_day1}

#  Ouvrir le calendrier
    Click Element    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div[2]/div/button[1]
    Sleep    5s  # Laisser le temps au calendrier de s'afficher

# Utiliser une séquence d'actions plus précise
    ${date_cell_xpath1} =    Set Variable    xpath=//td[contains(@class, 'dijitCalendarCurrentMonth')]//span[@class='dijitCalendarDateLabel' and text()='${current_day}']/parent::*

# Attendre et effectuer plusieurs actions
    Wait Until Element Is Visible    ${date_cell_xpath1}    timeout=20s
    Mouse Over    ${date_cell_xpath1}
    Sleep    1s
    Click Element    ${date_cell_xpath1}
    Sleep    1s
    Double Click Element    ${date_cell_xpath1}
    Capture Page Screenshot     calendar_.png
    Sleep    2s
     #la fin de livraison = dernier jour du mois suivant
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div[2]/div/button[2]        timeout=30s
    Click Element    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div[2]/div/button[2]
    Wait Until Element Is visible   xpath=/html/body/div[2]/div[1]/div[10]      timeout=30s
     # Attendre que le calendrier soit visible
    Wait Until Element Is Visible    xpath=//td[contains(@class, 'dijitCalendarDateTemplate')]   timeout=5s

# Aller au mois suivant (en supposant qu'un bouton "suivant" existe)
    Click Element    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div/div[1]/table/thead/tr[1]/th[3]

# Attendre que le calendrier se mette à jour
    Sleep    2s

# Trouver toutes les cellules des jours du mois suivant
    ${dates1}    Get WebElements    xpath=//td[contains(@class, 'dijitCalendarDateTemplate') and not(contains(@class, 'dijitCalendarNextMonth'))]/span

# Récupérer le dernier élément de la liste (dernier jour du mois)
    ${dernier_jour1}    Get From List    ${dates1}    -1

# Cliquer sur le dernier jour trouvé
    Double Click Element   ${dernier_jour1}

# Vérifier que la date est bien sélectionnée
    ${date_selectionnee1}=    Get Value    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div[2]/div/div[6]/div/input
    Log To Console    La date dernier jour est : ${date_selectionnee1}

When L'utilisateur navigue vers l'onglet 'Tarification'
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[1]/div[4]/div/div[3]/span[2]   timeout=2s
    Click Element    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[1]/div[4]/div/div[3]/span[2]
    Sleep    2s

Then Le formulaire de tarification est affiché avec les détails partiellement remplis
     Wait Until Page Contains    Informations de gestion
    Log    Le formulaire de tarification est affiché avec les détails partiellement remplis

When L'utilisateur saisit le prix brut unitaire forcé
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div[3]/div/div[101]/div/input       timeout=30s
    Input Text    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div[3]/div/div[101]/div/input    400

Then Le prix brut unitaire forcé est affiché dans le champ

    ${prix_but}=    Get Value   xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div[2]/div/div[6]/div/input
    Log To Console  La date sélectionnée est : ${prix_but}

When L'utilisateur sélectionne le niveau de prix d'application dans la liste déroulante
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div[3]/div/div[130]/div[3]    timeout=30s
    Click Element    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div[3]/div/div[130]/div[3]

    Wait Until Element Is Visible    xpath=(//input[@value='▼ '])[30]  60s
    Click Element                    xpath=(//input[@value='▼ '])[30]
    Sleep    2s

    # Attendre que la liste déroulante soit visible
    Wait Until Element Is Visible    xpath=//div[@class='dijitPopup dijitComboBoxMenuPopup' and not(contains(@style, 'display: none'))]    30s
    Click Element    xpath=//div[@class='a-combosimplemenuitem'][normalize-space(text())='2- Prix Spécial avant conditions commerciales (2)']
    Sleep    2s

Then Le niveau de prix d'application est sélectionné
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div[3]/div/div[130]/div[3]/input        timeout=30s
    ${niveau_prix}=    Get Value    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div[3]/div/div[130]/div[3]/input
    Log To Console  Le niveau de prix d'application est sélectionné :  ${niveau_prix}

When L'utilisateur coche la case "Forcé"
     Wait Until Element Is Visible       xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div[3]/div/div[134]/div/div[2]/input        timeout=30s
     Click Element    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div[3]/div/div[134]/div/div[2]/input

When L'utilisateur sélectionne le motif de forçage du prix dans la liste déroulante
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div[3]/div/div[138]/div[3]     timeout=30s

    Click Element    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div[3]/div/div[138]/div[3]

    Wait Until Element Is Visible    xpath=(//input[@value='▼ '])[32]  60s
    Click Element                    xpath=(//input[@value='▼ '])[32]
    Sleep    3s

    # Attendre que la liste déroulante soit visible
    Wait Until Element Is Visible    xpath=//div[@class='dijitPopup dijitComboBoxMenuPopup' and not(contains(@style, 'display: none'))]    30s
    Click Element    xpath=//div[@class='a-combosimplemenuitem'][normalize-space(text())='Prix Contractuel (PXC)']
    Capture Page Screenshot
    Sleep    5s

Then Le motif de forçage du prix est sélectionné
    ${motif_forcage}=    Get Value    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div[3]/div/div[138]/div[3]/input
    Log To Console   Le niveau de prix d'application est sélectionné :  ${motif_forcage}

When L'utilisateur clique sur le bouton "Enregistrer1"
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/button[15]        timeout=3s
    Click Element    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/button[15]

Then La liste des lignes de l'engagement est affichée avec les détails mis à jour

   # Attendre que la table soit chargée avec ses données
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div/div/div[3]/div[2]/div/div[2]/table/tr   timeout=30s


# Obtenir le nombre de colonnes
    ${columns}=    Get Element Count    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div/div/div[3]/div[2]/div/div[2]/table/tbody/tr[1]/td
    Log To Console    Nombre de colonnes trouvées: ${columns}

# Vérifier le contenu de chaque cellule
    FOR    ${col_index}    IN RANGE    1    ${columns + 1}
        ${cell_value2}=    Get Text    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div/div/div[3]/div[2]/div/div[2]/table/tbody/tr[1]/td[${col_index}]
        Log    Colonne ${col_index}: ${cell_value2}
        Should Not Be Empty    ${cell_value2}
    END

When L'utilisateur ferme la fenêtre de détail de l'engagement
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[9]/div[1]/table/tbody/tr/td[3]/div/span[5]      timeout=30s
    Click Element    xpath=/html/body/div[2]/div[1]/div[9]/div[1]/table/tbody/tr/td[3]/div/span[5]

Then L'engagement est affiché dans la liste des engagements en tête
     Wait Until Page Contains    Engagements        timeout=30s
    Log  L'engagement est affiché dans la liste des engagements en tête

# Attendre que la ligne soit visible
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[7]/div[4]/div[1]/div[3]/div[1]/div/div[3]/div[2]/div/div[2]/table/tr    timeout=30s

# Obtenir le nombre de colonnes dans la ligne
    ${columns1}=    Get Element Count    xpath=/html/body/div[2]/div[1]/div[7]/div[4]/div[1]/div[3]/div[1]/div/div[3]/div[2]/div/div[2]/table/tr[1]/td
    Log To Console    Nombre de colonnes: ${columns1}

# Récupérer le contenu de chaque cellule
    FOR    ${col_index}    IN RANGE    1    ${columns1 + 1}
        ${cell_value}=    Get Text    xpath=/html/body/div[2]/div[1]/div[7]/div[4]/div[1]/div[3]/div[1]/div/div[3]/div[2]/div/div[2]/table/tr[1]/td[${col_index}]
        Log To Console    Colonne ${col_index}: ${cell_value}
    END

When L'utilisateur revient à la liste des engagements et effectue une recherche en utilisant la date et le numéro de l'engagement
    #choisir la date de l'engagement
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[7]/div[4]/button[1]     timeout=30s
    Click Element    xpath=/html/body/div[2]/div[1]/div[7]/div[4]/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[8]   timeout=5s
    Log To Console    Vérification de la date
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    xpath=//td[contains(@class, 'dijitCalendarDateTemplate')]//span[text()='1']   timeout=5s
    Capture Page Screenshot
    Double Click Element   xpath=//td[contains(@class, 'dijitCalendarDateTemplate')]//span[text()='1']
    Sleep    5s

    #numero de l'engagement
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[7]/div[4]/div[14]/div/input     timeout=30s
    Input Text    xpath=/html/body/div[2]/div[1]/div[7]/div[4]/div[14]/div/input    ${NUMERO_ENGAGEMENT}

    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[7]/div[4]/div[8]/div[1]/div/div[1]      timeout=30s
    Click Element    xpath=/html/body/div[2]/div[1]/div[7]/div[4]/div[8]/div[1]/div/div[1]

And l'utilisateur bascule vers l'onglet détails engagement
    Wait Until Element Is Visible   xpath=/html/body/div[2]/div[1]/div[7]/div[4]/div[1]/div[1]/div[4]/div/div[2]/span[2]        timeout=30s
    Click Element    xpath=/html/body/div[2]/div[1]/div[7]/div[4]/div[1]/div[1]/div[4]/div/div[2]/span[2]


Then La liste des détails de l'engagement est correctement mise à jour
    Wait Until Page Contains    Détail(s)       timeout=30s
    Log  La liste des détails de l'engagement est correctement mise à jour

    Wait Until Element Is Visible         xpath=/html/body/div[2]/div[1]/div[7]/div[4]/div[1]/div[3]/div[2]/div/div[3]/div[2]/div/div[2]/table/tr[1]        timeout=30s

    # Obtenir le nombre de colonnes dans la ligne
    ${columns2}=    Get Element Count    xpath=/html/body/div[2]/div[1]/div[7]/div[4]/div[1]/div[3]/div[2]/div/div[3]/div[2]/div/div[2]/table/tr[1]/td
    Log To Console    Nombre de colonnes: ${columns2}

# Récupérer le contenu de chaque cellule
    FOR    ${col_index}    IN RANGE    1    ${columns2 + 1}
        ${cell_value1}=    Get Text    xpath=/html/body/div[2]/div[1]/div[7]/div[4]/div[1]/div[3]/div[2]/div/div[3]/div[2]/div/div[2]/table/tr[1]/td[${col_index}]
        Log To Console    Colonne ${col_index}: ${cell_value1}
    END