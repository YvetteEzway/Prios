*** Settings ***
Library    SeleniumLibrary    run_on_failure=Capture Page Screenshot
Library    DateTime
Library    Collections
Resource   01_Engagement_vente.robot


*** Variables ***
${PARENT_XPATH}      xpath=//div[@class='dijitReset dijitInputField dijitInputContainer']

${INPUT_FIELD}        //input[@id='a_r6c_id']
${SELECT_BUTTON}      xpath=//div[@id='widget_a_r6c_id']//div[@class='dijitReset dijitRight dijitButtonNode dijitArrowButton dijitDownArrowButton dijitArrowButtonContainer']
${OPTION_XPATH}       //li[contains(., 'Texte de l'option')]
${FIELD_ID}          xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[3]/div/input
${FIELD_ID2}         xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[4]/div/input
${PARENT_XPATH}      xpath=//div[@class='dijitReset dijitInputField dijitInputContainer']
${OPTION_TEXT}        xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[7]/div[2]/input
${FIELD_ID3}          xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[7]
${FIELD-ID4}         xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[7]/div[3]/input
${FIELD-ID5}         xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[10]/div[3]/input
${tiers_donneur_ordre}         ABBAYE61
${DATE_FORMAT}     %d/%m/%Y
${FIELD7}           xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[3]/div/input

${FIELD8}           xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[64]/div/input
${FIELD9}           xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[66]/div/input
${FIELD10}          xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[69]/div[3]/input
${FIELD_ID6}        xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[14]/div/input
${FIELD_ID11}       xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[16]/div/input
${FIELD_ID12}       xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[17]/div/input

${FIELD_ID13}       xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[76]/div/input
${FIELD_ID14}       xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[78]/div/input

${FIELD_ID19}       xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[127]/div/input
${FIELD_ID20}       xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[129]/div/input
${FIELD_ID21}       xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[134]/div[3]/input
${FIELD_ID22}       xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div[1]/div/div[119]/div/input
${FIELD_ID23}       xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div[1]/div/div[121]/div/input
${FIELD_ID25}       xpath=/html/body/div[2]/div[1]/div[11]/div[4]/div[1]/div[3]/div[1]/div/div[48]/div/input

*** Keywords ***
And L'utilisateur se trouve sur le menu principal de l'application

    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[7]/div[1]/table/tbody/tr/td[3]/div/span[5]    10s
    Click Element    xpath=/html/body/div[2]/div[1]/div[7]/div[1]/table/tbody/tr/td[3]/div/span[5]
    Sleep    2s
When L'utilisateur sélectionne "Ordres de livraison" dans la deuxième colonne

    [Documentation]    Sélectionne l'option "Ordres de livraison" sur la page.
    Execute JavaScript    document.evaluate("(//*[contains(text(), 'Ordres de livraison')])[1]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    Execute JavaScript    document.evaluate("(//*[contains(text(), 'Ordres de livraison')])[1]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()

    Capture Page Screenshot

When L'utilisateur sélectionne Ordres de livraison dans la troisième colonne

    [Documentation]    Sélectionne l'option "Ordres de livraison troisième colonne " sur la page.
    #Execute JavaScript    document.evaluate("(//*[contains(text(), 'Ordres de livraison')])[2]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    #Sleep    1s
    Execute JavaScript    document.evaluate("(//*[contains(text(), 'Ordres de livraison')])[2]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()
    Capture Page Screenshot

Then il est redirigé vers un formulaire affichant une liste vide d'ordres de livraison

    [Documentation]
    Wait Until Page Contains    Ordre(s) de livraison    30s
    Capture Page Screenshot

When l'utilisateur fait un clic droit sur la liste
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[7]/div[4]/div[1]/div[3]/div[1]/div/div[2]    30s
    Open Context Menu     xpath=/html/body/div[2]/div[1]/div[7]/div[4]/div[1]/div[3]/div[1]/div/div[2]

Then l'utilisateur voit une liste de choix avec:
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'dijitPopup dijitMenuPopup')]    30s

# Vérifie si un élément spécifique est bien présent
    Element Should Contain    xpath=//div[contains(@class, 'dijitPopup dijitMenuPopup')]    Nouveau...
    Sleep    5s
When l'utilisateur sélectionne "Nouveau..."
    ${menu_item}=    Execute JavaScript
    ...    return Array.from(document.getElementsByClassName('dijitMenuItemLabel')).find(el => el.textContent.trim() === 'Nouveau...');

    Execute JavaScript
    ...    arguments[0].click();
    ...    ARGUMENTS    ${menu_item}

    Sleep    5s

Then l'utilisateur est redirigé vers un formulaire pour ajouter un nouvel "Ordre de livraison"
    [Documentation]    Vérifie que la nouvelle page contient le texte spécifique pour confirmer la redirection.
    Wait Until Page Contains    Ordre de livraison [C] - Sté PRIOS - Etablissement CARQUEFOU    30s
    Log    Le texte "Ordres de livraison - Sté PRIOS - Etablissement CARQUEFOUOrdre de livraison [C] - Sté PRIOS - Etablissement CARQUEFOU" est bien présent sur la page.

 And si une commande existe déjà, les informations sont récupérées
    # Attendre que le parent de l'élément soit visible
    Wait Until Element Is Visible    ${PARENT_XPATH}    timeout=20s
    # Attendre que l'élément soit visible
    Wait Until Element Is Visible    ${FIELD_ID}    timeout=20s

    # Vérifier que le champ a une valeur non vide
    ${field_value}=    Get Value    ${FIELD_ID}
    Should Not Be Empty    ${field_value}    msg=Le champ a une valeur.
    Log    Le champ a une valeur.
    # Vérifier que le champ est grisé (readonly)
    ${readonly}=    Get Element Attribute    ${FIELD_ID}    readonly
    Should Be Equal As Strings    ${readonly}    true    msg=Le champ est en lecture seule.
    Log   Le champ est grisé et en mode lecture seule.


    # Attendre que l'élément soit visible
    Wait Until Element Is Visible    ${FIELD_ID2}    timeout=20s

    # Obtenir la valeur du champ
    ${field_value1}=    Get Value   ${FIELD_ID2}
    Should Not Be Empty    ${field_value1}    msg=Le champ a une valeur.
    Log    Le champ a une valeur.

    # Vérifier que le champ est grisé (readonly)
    ${readonly}=    Get Element Attribute    ${FIELD_ID2}    readonly
    Should Be Equal As Strings    ${readonly}    true    msg=Le champ est en lecture seule.
    Log   Le champ est grisé et en mode lecture seule.

L'utilisateur sélectionne un type d'ordre de livraison : "AB_OL Standard (AB1)"

    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[7]/div[1]/input    250s
    Click Element    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[7]/div[1]/input
    Click Element    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[7]/div[1]/input

    Wait Until Element Is Visible    xpath=(//input[@value='▼ '])[7]    250s
    Click Element                    xpath=(//input[@value='▼ '])[7]
    Sleep    10s

    # Attendre que la liste déroulante soit visible
    Wait Until Element Is Visible    xpath=//div[@class='dijitPopup dijitComboBoxMenuPopup' and not(contains(@style, 'display: none'))]    120s

# Cliquer sur l'élément AB_OL Standard (AB1)
    Click Element    xpath=//div[@class='a-combosimplemenuitem'][normalize-space(text())='AB_OL Standard (AB1)']
    Capture Page Screenshot

Then "AB_OL Standard (AB1)" est affiché dans le champ
    Wait Until Element Is Visible    ${FIELD-ID4}    timeout=120s
    # Vérifier que le champ a une valeur non vide
    ${field_value}=    Get Value    ${FIELD-ID4}
    Should Not Be Empty    ${field_value}    msg=Le champ type d'ordre de livraison a une valeur 'AB_OL Standard (AB1) '.
    Log    Le champ type d'ordre de livraison a une valeur 'AB_OL Standard (AB1)'.


Then "AB_Site de L Etrat (AB1)" est affiché dans le champ

     Wait Until Element Is Visible    ${FIELD-ID5}    timeout=20s
    # Vérifier que le champ a une valeur non vide
    ${field_value}=    Get Value    ${FIELD-ID5}
    Should Not Be Empty    ${field_value}    msg=Le champ Site a une valeur 'AB_Site de L Etrat (AB1) '.
    Log    Le champ Site a une valeur 'AB_Site de L Etrat (AB1)'.

And l'utilisateur saisit le 'Tiers donneur d'ordre' dans le champ

   # D'abord saisir le code donneur d'ordre
   Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[13]/div/input    timeout=10s
   Input Text    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[13]/div/input    ${tiers_donneur_ordre}

   # Utiliser TAB pour passer aux champs suivants et récupérer les données
   Press Keys    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[13]/div/input    TAB

   # Attendre que les autres champs soient remplis automatiquement
   #Nom du donneur d'ordre
   Wait Until Element Is Visible     ${FIELD_ID6}   30s
   ${field_value6}=    Get Value    ${FIELD_ID6}
   Should Not Be Empty    ${field_value6}    msg=Le champ "Nom du donneur d'ordre" a une valeur '${field_value6}'.
   Log    Le champ "Nom du donneur d'ordre" a une valeur '${field_value6}'.

   #"Code postale donneur ordre"
   Wait Until Element Is Visible     ${FIELD_ID11}      30s
   ${field_value11}=    Get Value    ${FIELD_ID11}
   Should Not Be Empty    ${field_value11}    msg=Le champ "Code postale donneur ordre" a une valeur '${field_value11}'.
   Log    Le champ "Code postale donneur ordre" a une valeur '${field_value11}'.

   #Ville du preneur d'ordre
   Wait Until Element Is Visible     ${FIELD_ID12}      30s
   ${field_value12}=    Get Value    ${FIELD_ID12}
   Should Not Be Empty    ${field_value12}    msg=Le champ "Ville du preneur d'ordre" a une valeur '${field_value12}'.
   Log    Le champ "Ville du preneur d'ordre" a une valeur '${field_value12}'.


And le contenu du champ "Date de livraison souhaitée est automatiquement renseignée avec la date actuelle +2 jours ouvrés
    ${date_ajd}        Get Current Date    result_format=datetime
    ${date_livraison}  Add Time To Date    ${date_ajd}    1 day    result_format=datetime

    # Vérifie si le jour suivant est un week-end (samedi/dimanche)
    WHILE    '${date_livraison.strftime("%A")}' in ['Saturday', 'Sunday']
        ${date_livraison}  Add Time To Date    ${date_livraison}    1 day    result_format=datetime
    END

    ${date_livraison}  Add Time To Date    ${date_livraison}    1 day    result_format=datetime

    WHILE    '${date_livraison.strftime("%A")}' in ['Saturday', 'Sunday']
        ${date_livraison}  Add Time To Date    ${date_livraison}    1 day    result_format=datetime
    END

    ${date_livraison_str}  Convert Date    ${date_livraison}    ${DATE_FORMAT}

    # Lire la valeur du champ date dans l'application (par exemple avec id ou xpath)
    ${valeur_champ}     Get Value    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[19]/div/input

    # Comparaison
    Should Be Equal    ${valeur_champ}    ${date_livraison_str}

When L'utilisateur saisit la date du jour dans le champ date de départ
    ${current_day} =    Get Current Date    result_format=%d
    ${current_day} =    Evaluate    str(int('${current_day}'))    # Supprimer le zéro devant si nécessaire
    Log    Date du jour : ${current_day}
# Ouvrir le calendrier
    Click Element    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/button[5]

    Sleep    3s
     ${date_cell_xpath} =    Set Variable    xpath=//td[contains(@class, 'dijitCalendarCurrentMonth')]//span[@class='dijitCalendarDateLabel' and text()='${current_day}']/parent::*

# Attendre et effectuer plusieurs actions
    Wait Until Element Is Visible    ${date_cell_xpath}    timeout=20s
    Mouse Over    ${date_cell_xpath}
    Sleep    1s
    Click Element    ${date_cell_xpath}
    Sleep    1s
    Double Click Element    ${date_cell_xpath}
    Sleep    10s
    Capture Page Screenshot    datededepart.png

And l'utilisateur click sur le bouton enregisterer
    # Faire défiler jusqu'au bouton d'enregistrement avec un offset vertical
    Execute JavaScript    document.evaluate("/html/body/div[2]/div[1]/div[8]/div[4]/button[12]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView({behavior: 'smooth', block: 'center'});
    Sleep    2s

    # Attendre et cliquer sur le bouton
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/button[12]    10s
    Click Element    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/button[12]

Given l'utilisateur est sur le détail de l'ordre de livraison
    [Documentation]    Vérifie que la page affiche le titre des détails des ordres de livraison
    Wait Until Page Contains    Détails ordres de livraison - Sté PRIOS - Etablissement CARQUEFOU    30s
    Log    Le titre "Détails ordres de livraison - Sté PRIOS - Etablissement CARQUEFOU" est bien présent sur la page

When l'utilisateur clique sur le bouton + pour ajouter un produit

    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[3]/div[1]/div[1]/div[1]/table/tbody/tr[1]/td/img
    Click Element    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[3]/div[1]/div[1]/div[1]/table/tbody/tr[1]/td/img

When il entre les 3 premiers caractères du code produit "ABBAYE61"
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[3]/div/input    10s
    Input Text    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[3]/div/input   IMS
    Press Keys    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[3]/div/input   TAB

Then une fenêtre de choix de produits apparaît
    [Documentation]
    Wait Until Page Contains    Sélection des Produits - Sté PRIOS.Etablissement CARQUEFOU    30s
    Log    Le titre "Sélection des Produits - Sté PRIOS.Etablissement CARQUEFOU" est bien présent sur la page


When il choisit le produit "IMSFB1"

    Wait Until Element Is Visible   xpath=//div[contains(@class, 'dijitDialog') and contains(@class, 'dijitDialogFocused')]//div[contains(text(), 'IMSFB1')]
    Sleep    2s
    Double Click Element    xpath=//div[contains(@class, 'dijitDialog') and contains(@class, 'dijitDialogFocused')]//div[contains(text(), 'IMSFB1')]

    Capture Page Screenshot

Then les champs sont pré-remplis avec les informations du produit
   #Ville du preneur d'ordre
   Wait Until Element Is Visible     ${FIELD7}      30s
   ${field_value15}=    Get Value    ${FIELD7}
   Should Not Be Empty    ${field_value15}    msg=Le champ "Ville du preneur d'ordre" a une valeur '${field_value15}'.
   Log    Le champ "Ville du preneur d'ordre" a une valeur '${field_value15}'.


Given l'utilisateur saisit la quantité à livrer dans le champ Quantité

    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[25]/div/input
    Input Text    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[25]/div/input    2.500
    Sleep   2s

Then l'utilisateur verifie les informations dans la section Livraison

   Wait Until Element Is Visible     ${FIELD8}      30s
   ${field_value16}=    Get Value    ${FIELD8}
   Should Not Be Empty    ${field_value16}    msg=Le champ Tiers à livrer a une valeur du Code tiers Donneur ordre '${field_value16}'.
   Log    Le champ Tiers à livrer a une valeur du Code tiers Donneur ordre '${field_value16}'.


   Wait Until Element Is Visible    ${FIELD9}    timeout=120s
    # Vérifier que le champ a une valeur non vide
   ${field_value3}=    Get Value    ${FIELD9}
   Should Not Be Empty    ${field_value3}    msg=Le champ Tiers à livrer a une valeur du Nom du donneur d'ordre .
   Log    Le champ Tiers à livrer a une valeur du Nom du donneur d'ordre : '${field_value3}'    level=INFO

   Wait Until Element Is Visible    ${FIELD10}    timeout=120s
    # Vérifier que le champ a une valeur non vide
   ${field_value10}=    Get Value    ${FIELD10}
   Should Not Be Empty    ${field_value10}    msg=Le champ Lieu de livraison a une valeur
    Log    Le champ Lieu de livraison a une valeur : '${field_value10}'     level=INFO

    #SILO
    Wait Until Element Is Visible    ${FIELD_ID13}    timeout=120s
    # Vérifier que le champ a une valeur non vide
    ${field_value13}=    Get Value    ${FIELD_ID13}
    Should Not Be Empty    ${field_value13}    msg=Le champ SILO a une valeur
    Log    Le champsilo a une valeur : '${field_value13}'  level=INFO

    Wait Until Element Is Visible    ${FIELD_ID14}    timeout=120s
    # Vérifier que le champ a une valeur non vide
    ${field_value14}=    Get Value    ${FIELD_ID14}
    Should Not Be Empty    ${field_value14}    msg=Le champ a une valeur
    Log    Le champ a une valeur : '${field_value14}'     level=INFO

    Sleep    1s
Then l'utilisateur verifie les informations dans la section Facturation

    #verification du champ engament
    Wait Until Element Is Visible    ${FIELD_ID19}    timeout=120s
    Click Element    ${FIELD_ID19}
    Sleep    1s
    # Vérifier que le champ a une valeur non vide
    ${field_value19}=    Get Value    ${FIELD_ID19}
    Should Not Be Empty    ${field_value19}    msg=Le champ numero d'engagement a une valeur
    Log    Le champ numero d'engagement a une valeur : '${field_value19}'     level=INFO
    Set Suite Variable    ${ENGAGEMENT_NUMERO}    ${field_value19}

    Wait Until Element Is Visible    ${FIELD_ID20}    timeout=120s
    Click Element    ${FIELD_ID20}
    Sleep    1s
    # Vérifier que le champ a une valeur non vide
    ${field_value20}=    Get Value    ${FIELD_ID20}
    Should Not Be Empty    ${field_value20}    msg=Le champ Numéro de ligne d'engagement a une valeur
    Log    Le champ Numéro de ligne d'engagement a une valeur : '${field_value20}'     level=INFO

Then l'utilisateur verifie les informations dans la section 'Société et établissements commerciaux'
    #Vérififcation du champ
    Wait Until Element Is Visible    ${FIELD_ID21}    timeout=120s
    Click Element    ${FIELD_ID21}
    Sleep    1s
    # Vérifier que le champ a une valeur non vide
    ${field_value21}=    Get Value    ${FIELD_ID21}
    Should Not Be Empty    ${field_value21}    msg=Le champ société a une valeur
    Log    Le champ société a une valeur : '${field_value21}'     level=INFO

And l'utilisateur clique sur le bouton '€ ' depuis le menu vertical à droite
    Wait Until Element Is Visible    xpath=//img[contains(@class, 'a-image') and contains(@src, '24DFAC60BCC6A61526E2DFDA5F5E3F45')]    timeout=30s
    Click Element    xpath=//img[contains(@class, 'a-image') and contains(@src, '24DFAC60BCC6A61526E2DFDA5F5E3F45')]

Then ouverture d'une fenetre pour Infos Tarification / OL [M] - Sté PRIOS - Etablissement CARQUEFOU avec le prix brute
    [Documentation]
    Wait Until Page Contains    Infos Tarification / OL [M] - Sté PRIOS - Etablissement CARQUEFOU    30s
    Log    Le texte "Infos Tarification / OL [M] - Sté PRIOS - Etablissement CARQUEFOU" s'affiche bien sur la page.

    Wait Until Element Is Visible    ${FIELD_ID25}    timeout=120s
    Click Element    ${FIELD_ID25}
    Sleep    1s
    # Vérifier que le champ a une valeur non vide
    ${field_value25}=    Get Value    ${FIELD_ID25}
    Should Not Be Empty    ${field_value25}    msg=Le champ Prix brute unitaire forcé a une valeur
    Log    Le champ Prix brute unitaire forcé a une valeur : '${field_value25}'     level=INFO


Fermer la fenêtre pour info tarification
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[11]/div[1]/table/tbody/tr/td[3]/div/span[5]     timeout=10s
    Click Element    xpath=/html/body/div[2]/div[1]/div[11]/div[1]/table/tbody/tr/td[3]/div/span[5]

Cliquer sur le bouton enregistrer
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/button[13]   timeout=10s
    Click Element   xpath=/html/body/div[2]/div[1]/div[10]/div[4]/button[13]
    Sleep    1s
When l'utilisateur clique sur le bouton Fermer pour fermer le formulaire d'ajout produit
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/button[13]     timeout=10s
    Click Element    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/button[13]

Then le formulaire d'ajout de produit est fermé et les détails de l'ordre de livraison s'affichent au premier plan

    Wait Until Element Is Visible         xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div[1]/div/div[4]/div[2]/div/div[2]/table/tr   timeout=10s

    # Obtenir le nombre de colonnes dans la ligne
    ${columns2}=    Get Element Count    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div[1]/div/div[4]/div[2]/div/div[2]/table/tr/td
    Log To Console    Nombre de colonnes: ${columns2}

# Récupérer le contenu de chaque cellule
    FOR    ${col_index4}    IN RANGE    1    ${columns2 + 1}
        ${cell_xpath}=    Set Variable     xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div[1]/div/div[4]/div[2]/div/div[2]/table/tr/td[${col_index4}]
        Wait Until Element Is Visible    ${cell_xpath}    timeout=5s
        ${cell_value}=    Get Text    ${cell_xpath}
        Log To Console    Colonne ${col_index4}: ${cell_value}
    END
    Sleep    3s
When l'utilisateur clique sur le bouton Valider

      Wait Until Element Is Visible   xpath=/html/body/div[2]/div[1]/div[9]/div[4]/button[12]   timeout=30s
      Wait Until Element Is Enabled     xpath=/html/body/div[2]/div[1]/div[9]/div[4]/button[12]
      Click Element    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/button[12]

Then Un document PDF d'un OL contenant les informations pour l'ordre de livraison s'ouvre dans un nouvel onglet avec le statut validé
   ${handles}=    Get Window Handles

    # Switch to the new tab (last handle in the list)
    Switch Window    ${handles}[-1]

    # Verify we are on the PDF tab
    #Wait Until Page Contains Element    //embed[@type='application/pdf']    timeout=30s
    Sleep    3s
    # Optional: Switch back to main window if needed
    Switch Window    ${handles}[1]
    log  L'utilisateur est redirigé vers un formulaire contenant une liste des 'Ordres de livraison'
    Sleep    3s

And l'utilisateur la fenetre contenant une liste des ordres de livraison et il est rediger vers le menu principal
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[7]/div[4]/button[10]        timeout=30s
    Wait Until Element Is Enabled    xpath=/html/body/div[2]/div[1]/div[7]/div[4]/button[10]
    Click Element    xpath=/html/body/div[2]/div[1]/div[7]/div[4]/button[10]
    Sleep    3s
When L'utilisateur choisit "Engagements" pour le OL créer dans la deuxième colonne
    [Documentation]    Sélectionne l'option "Ordres de livraison" sur la page.
    Execute JavaScript    document.evaluate("(//*[contains(text(), 'Engagements')])[1]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    Sleep    1s
    Execute JavaScript    document.evaluate("(//*[contains(text(), 'Engagements')])[1]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()
    Sleep    3s

When L'utilisateur sélectionne "Engagements" pour le OL dans la troisième colonne
    [Documentation]    Sélectionne l'option "Ordres de livraison" sur la page.
    Execute JavaScript    document.evaluate("(//*[contains(text(), 'Engagements')])[2]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()

Then L'utilisateur est redirigé vers un formulaire contenant une liste d'engagements vide avec bouton ajout
    Wait Until Page Contains    Engagements de ventes - Sté PRIOS - Etablissement CARQUEFOU    30s
    Log  Engagements de ventes - Sté PRIOS - Etablissement CARQUEFOU

When l'utilisateur saisi le numéro d'engagement précedemment créer dans le champ Numéro d'engagement
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[7]/div[4]/div[14]/div/input     timeout=30s
    Input Text    xpath=/html/body/div[2]/div[1]/div[7]/div[4]/div[14]/div/input    ${ENGAGEMENT_NUMERO}

And l'utilisateur clique sur le bouton loupe
    Wait Until Element Is Visible    xpath=//img[contains(@class, 'a-image') and contains(@src, '540900E90F2F7123BB05B76317E76008')]    timeout=30s
    Click Element    xpath=//img[contains(@class, 'a-image') and contains(@src, '540900E90F2F7123BB05B76317E76008')]
    Sleep    3s
When la ligne d'engagement s'affiche dans la liste des engagements

    ${columns3}=    Get Element Count    xpath=/html/body/div[2]/div[1]/div[7]/div[4]/div[1]/div[3]/div[1]/div/div[3]/div[1]/table/tr/td
    Log To Console    Nombre de colonnes: ${columns3}

# Récupérer le contenu de chaque cellule
    FOR    ${col_index1}    IN RANGE    1    ${columns3 + 1}
        ${cell_value2}=    Get Text    xpath=/html/body/div[2]/div[1]/div[7]/div[4]/div[1]/div[3]/div[1]/div/div[3]/div[1]/table/tr/td[${col_index1}]
        Log To Console    Colonne ${col_index1}: ${cell_value2}
    END
    Sleep    3s

Then l'utilisateur navigue sur l'onglet "Détails"
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[7]/div[4]/div[1]/div[1]/div[4]/div/div[2]/span[2]       timeout=30s
    Wait Until Element Is Enabled    xpath=/html/body/div[2]/div[1]/div[7]/div[4]/div[1]/div[1]/div[4]/div/div[2]/span[2]       timeout=30s
    Click Element    xpath=/html/body/div[2]/div[1]/div[7]/div[4]/div[1]/div[1]/div[4]/div/div[2]/span[2]

Then la ligne pou les détails de l'engagement s'affiche

    ${columns4}=    Get Element Count    xpath=/html/body/div[2]/div[1]/div[7]/div[4]/div[1]/div[3]/div[2]/div/div[3]/div[1]/table/tr/td
    Log To Console    Nombre de colonnes: ${columns4}

# Récupérer le contenu de chaque cellule
    FOR    ${col_index2}    IN RANGE    1    ${columns4 + 1}
        ${cell_value3}=    Get Text    xpath=/html/body/div[2]/div[1]/div[7]/div[4]/div[1]/div[3]/div[2]/div/div[3]/div[1]/table/tr/td[${col_index2}]
        Log To Console    Colonne ${col_index2}: ${cell_value3}
    END
    Sleep    3s

And l'utilisateur verifie la colonne reste à livrer sur la ligne

   ${header_count}=    Get Element Count   xpath=/html/body/div[2]/div[1]/div[7]/div[4]/div[1]/div[3]/div[2]/div/div[3]/div[2]/div/div[2]/table/tr/th
   Log To Console    Nombre de colonnes: ${header_count}

   @{headers}=      Create List
   FOR  ${i}    IN RANGE    1      ${header_count +1}
        ${header_text}=     Get Text     xpath=/html/body/div[2]/div[1]/div[7]/div[4]/div[1]/div[3]/div[2]/div/div[3]/div[2]/div/div[2]/table/tr/th[${i}]
        Append To List  ${headers}  ${header_text}
        Log To Console    Entete ${i}: ${header_text}
   END

   ${row_count}=    Get Element Count   xpath=/html/body/div[2]/div[1]/div[7]/div[4]/div[1]/div[3]/div[2]/div/div[3]/div[2]/div/div[2]/table/tr
   Log To Console    Nombre de lignes: ${row_count}

    FOR    ${row}    IN RANGE    1    ${row_count + 1}
        @{row_data}=    Create List
        FOR    ${col}    IN RANGE    1    ${header_count + 1}
            ${cell_text}=    Get Text    xpath=/html/body/div[2]/div[1]/div[7]/div[4]/div[1]/div[3]/div[2]/div/div[3]/div[2]/div/div[2]/table/tr[${row}]/td[${col}]
            Append To List    ${row_data}    ${cell_text}
        END
        Log To Console    Ligne ${row}: ${row_data}
    END

   # Run Keyword If    ${target_index} == 0    Fail    Colonne 'Reste à livrer' non trouvée

   # ${reste_a_livrer}=    Get Text    xpath=/html/body/div[2]/div[1]/div[7]/div[4]/div[1]/div[3]/div[2]/div/div[3]/div[2]/div/div[2]/table/tr/td[${target_index}]
    #Log To Console    Valeur de "Reste à livrer" : ${reste_a_livrer}
