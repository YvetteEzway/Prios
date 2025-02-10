*** Settings ***
Library    SeleniumLibrary    run_on_failure=Capture Page Screenshot
Library    OperatingSystem
Library    RequestsLibrary
Library    BuiltIn
Library    String
Library    BuiltIn



*** Variables ***
${ORDRES_LIVRAISON_BUTTON}    xpath=(//*[contains(text(), 'Ordres de livraison')])[1]
${ORDRES_LIVRAISON2_BUTTON}   xpath=(//*[contains(text(), 'Ordres de livraison')])[2]
@{OPTIONS}    PRIOS Satelit (SATF AS)    PRIOS A-M Base    PRIOS A-M Bandes    PRIOS A-M Achats    PRIOS A-M Stocks    PRIOS A-M Ventes    PRIOS A-M Céréales    PRIOS A-M Prix de revient
@{OPTIONS2}    PRIOS A-M Déclarations   PRIOS A-M Traçabilité    PRIOS A-M Evènements   PRIOS A-M Reporting    PRIOS A-M Logistique    PRIOS A-M Interfaces externes    PRIOS A-M Interface comptable    PRIOS A-M Partenaires
@{2emeCOL}     Tarifs ventes    Valorisation transports    Engagements    Incorporations    Aliments/Achats Céréales    Ordres de livraison    Ordonnances    Tournées
@{2emeCOL2}    Bons de livraison   Facturation    Prévisions    Commissions / Ventes   Ristournes
${ORDRES_LIVRAISON_BUTTON}    xpath=(//*[contains(text(), 'Ordres de livraison')])[1]

@{3emeCOL}     Ordres de livraison  OL par Produit   OL par Tiers   Contrôle des OL   Export Excel  Besoins par produit  Planifications OL  Cadencier
@{3emeCOL2}    Livraison sur OL  Visual Planning  Envoi des OL vers Syst. Ext.  Rapports
${ORDRES_LIVRAISON2_BUTTON}   xpath=(//*[contains(text(), 'Ordres de livraison')])[2]

${Ent_Type_OL}    OL Standard (STD)

${FIELD_ID}          xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[3]/div/input
                    # /html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[3]/div/input
${FIELD_ID2}         xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[4]/div/input
${PARENT_XPATH}      xpath=//div[@class='dijitReset dijitInputField dijitInputContainer']

${INPUT_FIELD}        //input[@id='a_r6c_id']
${SELECT_BUTTON}      xpath=//div[@id='widget_a_r6c_id']//div[@class='dijitReset dijitRight dijitButtonNode dijitArrowButton dijitDownArrowButton dijitArrowButtonContainer']
${OPTION_XPATH}       //li[contains(., 'Texte de l'option')]


${OPTION_TEXT}        xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[7]/div[2]/input
${FIELD_ID3}          xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[7]
${FIELD-ID4}         xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[7]/div[3]/input
${FIELD-ID5}         xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[10]/div[3]/input
${code_donneur_ordre}         84_TEST13

${TABLE_HADERS_XPATH}     xpath=//div[contains(@class, 'dijitDialog')][last()]//th[contains(@class, 'dgrid-cell')]//div[contains(@class, 'dgrid-resize-header-container')]

${TABLE_CELLS_XPATH}    xpath=//div[contains(@class, 'dijitDialog')][last()]//table/tr/td
${TABLE_CELLS_XPATH1}    xpath=//div[contains(@class, 'dijitDialog')][last()]//table/tr/td[first()]

${TABLE_HADERS_ENTETE}  xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div[1]/div/div[4]/div[1]/table/tr


${TABLE_CELLS_DET}       xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[1]/div[3]/div[1]/div/div[4]/div[2]/div/div[2]/table/tr[position()=1 or position()=2]/td


${HORIZONTAL_SCROLL_ELEMENT_XPATH}     xpath=//*[@id="a_a5s_id"]

*** Keywords ***
Given L'utilisateur se trouve sur la page "Plateformes métier"
    [Documentation]    Vérifie que l'utilisateur est sur la page "Plateformes métier".
    Wait Until Page Contains    Plateformes    30s

When L'utilisateur sélectionne l'option "PRIOS Agriculture" dans la section "Plateformes métier"
    [Documentation]    Sélectionne l'option "PRIOS Agriculture" sur la page.
    Wait Until Element Is Visible    xpath=/html/body/pr-root/pr-main/div/pr-grid-main/div/div/div/div[1]/div[2]/div/div/div/div[1]/div[3]    10s
    Click Element    xpath=/html/body/pr-root/pr-main/div/pr-grid-main/div/div/div/div[1]/div[2]/div/div/div/div[1]/div[3]

Then Il est redirigé vers une nouvelle page avec les menus de navigation
    [Documentation]    Vérifie que la nouvelle page contient le texte spécifique pour confirmer la redirection.
    Wait Until Page Contains    Prios    30s

Then Les menus de navigation affichent les options suivantes dans les premières "8" options :

    [Documentation]    Vérifie que les 8 options spécifiées sont présentes dans le menu.
    # Ouvrir l'onglet contenant les options (assurez-vous que vous êtes dans le bon onglet)
    ${handles} =    Get Window Handles
    Switch Window    ${handles}[-1]
    Sleep    60s

    # Vérifier chaque option avec un défilement si nécessaire
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

Then Les menus de navigation affichent les options suivantes :

    FOR    ${option2}    IN    @{OPTIONS2}
        Log    Vérification de l'option : ${option2}

        # Faire défiler l'option dans la vue si nécessaire
        Execute JavaScript    document.evaluate("//*[contains(text(), '${option2}')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);

        # Attendre que l'option soit visible après le défilement
        Wait Until Element Is Visible    xpath=//*[contains(text(), '${option2}')]    timeout=30s

        # Vérifier que l'option est présente
        ${element_found} =    Execute JavaScript    return document.evaluate("//*[contains(text(), '${option2}')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
        Run Keyword If    '${element_found}' != 'None'    Log    Option ${option2} trouvée.
        Run Keyword If    '${element_found}' == 'None'    Fail    Option ${option2} non trouvée.
    END

When L'utilisateur clique sur "PRIOS A-M Ventes"
    [Documentation]    Sélectionne l'option "PRIOS A-M Ventes" sur la page.
    Execute JavaScript    document.evaluate("//*[contains(text(), 'PRIOS A-M Ventes')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);

    Wait Until Element Is Visible    xpath=//*[contains(text(), 'PRIOS A-M Ventes')]    30s
    Click Element    xpath=//*[contains(text(), 'PRIOS A-M Ventes')]

    Sleep    60s

Then L'affichage de la page présente les fonctions suivantes dans la première partie de la deuxième colonne :

   FOR    ${option3}    IN    @{2emeCOL}
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

Then L'affichage de la page présente les fonctions suivantes dans la seconde partie de la deuxième colonne :

   FOR    ${option4}    IN    @{2emeCOL2}
        Log    Vérification de l'option : ${option4}

        # Faire défiler l'option dans la vue si nécessaire
        Execute JavaScript    document.evaluate("//*[contains(text(), '${option4}')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);

        # Attendre que l'option soit visible après le défilement
        Wait Until Element Is Visible    xpath=//*[contains(text(), '${option4}')]    timeout=30s

        # Vérifier que l'option est présente
        ${element_found} =    Execute JavaScript    return document.evaluate("//*[contains(text(), '${option4}')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
        Run Keyword If    '${element_found}' != 'None'    Log    Option ${option4} trouvée.
        Run Keyword If    '${element_found}' == 'None'    Fail    Option ${option4} non trouvée.
   END
When L'utilisateur sélectionne "Ordres de livraison" dans la deuxième colonne
    [Documentation]    Sélectionne l'option "Ordres de livraison" sur la page.
    Execute JavaScript    document.evaluate("(//*[contains(text(), 'Ordres de livraison')])[1]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    Sleep    1s
    Execute JavaScript    document.evaluate("(//*[contains(text(), 'Ordres de livraison')])[1]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()

    Sleep    10s

Then Les fonctions suivantes apparaissent dans la première partie de la troisième colonne :

    FOR    ${option5}    IN    @{3emeCOL}
        Log    Vérification de l'option : ${option5}

        # Faire défiler l'option dans la vue si nécessaire
        Execute JavaScript    document.evaluate("//*[contains(text(), '${option5}')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);

        # Attendre que l'option soit visible après le défilement
        Wait Until Element Is Visible    xpath=//*[contains(text(), '${option5}')]    timeout=30s

        # Vérifier que l'option est présente
        ${element_found} =    Execute JavaScript    return document.evaluate("//*[contains(text(), '${option5}')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
        Run Keyword If    '${element_found}' != 'None'    Log    Option ${option5} trouvée.
        Run Keyword If    '${element_found}' == 'None'    Fail    Option ${option5} non trouvée.
   END

Then Les fonctions suivantes apparaissent dans la seconde partie de la troisième colonne :

   FOR    ${option6}    IN    @{3emeCOL2}
        Log    Vérification de l'option : ${option6}

        # Faire défiler l'option dans la vue si nécessaire
        Execute JavaScript    document.evaluate("//*[contains(text(), '${option6}')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);

        # Attendre que l'option soit visible après le défilement
        Wait Until Element Is Visible    xpath=//*[contains(text(), '${option6}')]    timeout=60s

        # Vérifier que l'option est présente
        ${element_found} =    Execute JavaScript    return document.evaluate("//*[contains(text(), '${option6}')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
        Run Keyword If    '${element_found}' != 'None'    Log    Option ${option6} trouvée.
        Run Keyword If    '${element_found}' == 'None'    Fail    Option ${option6} non trouvée.
   END

When L'utilisateur sélectionne Ordres de livraison dans la troisième colonne

    [Documentation]    Sélectionne l'option "Ordres de livraison troisième colonne " sur la page.
    Execute JavaScript    document.evaluate("(//*[contains(text(), 'Ordres de livraison')])[2]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    Sleep    1s
    Execute JavaScript    document.evaluate("(//*[contains(text(), 'Ordres de livraison')])[2]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()

    Sleep    60s
    Wait Until Element Is Visible    xpath=//*[contains(@class, 'dijitDialogTitle') and contains(text(), 'Ordres de livraison - Sté PRIOS - Etablissement CARQUEFOU')]    timeout=30s

Then L'utilisateur est redirigé vers un formulaire contenant une liste vide d'ordres de livraison

    [Documentation]    Vérifie que la nouvelle page contient le texte spécifique pour confirmer la redirection.
    Wait Until Page Contains    Ordres de livraison - Sté PRIOS - Etablissement CARQUEFOU    30s
    Log    Le texte "Ordres de livraison - Sté PRIOS - Etablissement CARQUEFOU" est bien présent sur la page.
When L'utilisateur clique sur le bouton "+"
    Execute JavaScript    document.body.style.zoom = '70%'

    [Documentation]    Sélectionne l'option "le bouton +" sur la page.
    Wait Until Element Is Visible    xpath=//img[contains(@class, 'a-image') and contains(@src, 'CB8CF15EBC54179FBC57E708D9C763D9')]    timeout=30s

    Execute JavaScript    document.evaluate("//img[contains(@class, 'a-image') and contains(@src, 'CB8CF15EBC54179FBC57E708D9C763D9')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    Sleep    10s
    Click Element    xpath=//img[contains(@class, 'a-image') and contains(@src, 'CB8CF15EBC54179FBC57E708D9C763D9')]
    Sleep    30s
Then L'utilisateur est redirigé vers un formulaire pour ajouter un nouvel ordre de livraison
    [Documentation]    Vérifie que la nouvelle page contient le texte spécifique pour confirmer la redirection.
    Wait Until Page Contains    Ordre de livraison [C] - Sté PRIOS - Etablissement CARQUEFOU    30s
    Log    Le texte "Ordres de livraison - Sté PRIOS - Etablissement CARQUEFOUOrdre de livraison [C] - Sté PRIOS - Etablissement CARQUEFOU" est bien présent sur la page.

And Si une commande a déjà été créée, alors le formulaire récupère les informations précédemment saisies pour le Preneur d'ordre

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

 L'utilisateur sélectionne un type d'ordre de livraison : "OL Standard (STD)"

    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[7]/div[1]/input    250s
    Click Element    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[7]/div[1]/input
    Click Element    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[7]/div[1]/input

    Wait Until Element Is Visible    xpath=(//input[@value='▼ '])[7]    250s
    Click Element                    xpath=(//input[@value='▼ '])[7]
    Sleep    30s

    # Attendre que la liste déroulante soit visible
    Wait Until Element Is Visible    xpath=//div[@class='dijitPopup dijitComboBoxMenuPopup' and not(contains(@style, 'display: none'))]    120s

# Cliquer sur l'élément OL Standard (STD)
    Click Element    xpath=//div[@class='a-combosimplemenuitem'][normalize-space(text())='OL Standard (STD)']
    Capture Page Screenshot

Then "OL Standard (STD)" est affiché dans le champ
    Wait Until Element Is Visible    ${FIELD-ID4}    timeout=120s
    # Vérifier que le champ a une valeur non vide
    ${field_value}=    Get Value    ${FIELD-ID4}
    Should Not Be Empty    ${field_value}    msg=Le champ type d'ordre de livraison a une valeur 'OL Standard (STD)' '.
    Log    Le champ type d'ordre de livraison a une valeur 'OL Standard (STD)'.

When L'utilisateur sélectionne un Site : "Z COREAL (ZCO)"
     Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[10]/div[1]/input    250s
     Click Element                    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[10]/div[1]/input
     Click Element                    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[10]/div[1]/input

     Wait Until Element Is Visible    xpath=(//input[@value='▼ '])[8]    60s
     Click Element                    xpath=(//input[@value='▼ '])[8]
     Sleep    20s

     # Attendre que la liste déroulante soit visible

# Cliquer sur l'élément
    Wait Until Element Is Visible    xpath=//div[@class='a-combosimplemenuitem'][normalize-space(text())='Z COREAL (ZCO)']      30s
    Click Element    xpath=//div[@class='a-combosimplemenuitem'][normalize-space(text())='Z COREAL (ZCO)']
    Capture Page Screenshot

Then "Z COREAL (ZCO)" est affiché dans le champ

     Wait Until Element Is Visible    ${FIELD-ID5}    timeout=20s

    # Vérifier que le champ a une valeur non vide
    ${field_value}=    Get Value    ${FIELD-ID5}
    Should Not Be Empty    ${field_value}    msg=Le champ Site a une valeur 'Z COREAL (ZCO) '.
    Log    Le champ Site a une valeur 'Z COREAL (ZCO)'.

And l'utilisateur saisit le 'Tiers donneur d'ordre' dans le champ
   
   # D'abord saisir le code donneur d'ordre
   Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[13]/div/input
   Input Text    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[13]/div/input    ${code_donneur_ordre}

   # Utiliser TAB pour passer aux champs suivants et récupérer les données
   Press Keys    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[13]/div/input    TAB

   # Attendre que les autres champs soient remplis automatiquement
   Sleep    2s

And l'utilisateur click sur le bouton enregisterer
     Execute JavaScript    document.body.style.zoom = '80%'
    # Faire défiler jusqu'au bouton d'enregistrement avec un offset vertical
    Execute JavaScript    document.evaluate("/html/body/div[2]/div[1]/div[8]/div[4]/button[12]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView({behavior: 'smooth', block: 'center'});
    Sleep    2s

    # Attendre et cliquer sur le bouton
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/button[12]    10s
    Click Element    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/button[12]

Then L'utilisateur est redirigeé vers les details des ordres de livraison

    # Execute JavaScript    document.body.style.zoom = '80%'

    [Documentation]    Vérifie que la page affiche le titre des détails des ordres de livraison
    Wait Until Page Contains    Détails ordres de livraison - Sté PRIOS - Etablissement CARQUEFOU    30s
    Log    Le titre "Détails ordres de livraison - Sté PRIOS - Etablissement CARQUEFOU" est bien présent sur la page

When l'utilisateur clique sur le bouton + pour ajouter un produit

    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[3]/div[1]/div[1]/div[1]/table/tbody/tr[1]/td/img
    Click Element    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[3]/div[1]/div[1]/div[1]/table/tbody/tr[1]/td/img
    Sleep    2s

Then Un formulaire de sélection de produit s'affiche dans une fenêtre pop-up

    [Documentation]
    Wait Until Page Contains    Détail ordre de livraison [C] - Sté PRIOS - Etablissement CARQUEFOU    60s
    Log    Le titre "Détail ordre de livraison [C] - Sté PRIOS - Etablissement CARQUEFOU" est bien présent sur la page

And L'utilisateur saisit le nom Produit dans le champ Produit 

   Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[3]/div/input
   Input Text    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[3]/div/input    DPT1
   Press Keys    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[3]/div/input   TAB
   Sleep    2s

Given l'utilisateur saisit la quantité à livrer dans le champ Quantité

    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[25]/div/input
    Input Text    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[25]/div/input    1.500
    Sleep   2s
When L'utilisateur saisit le Silo dans le champ Silo

    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[76]/div/input
    Input Text    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[76]/div/input     S1

    # Utiliser TAB pour passer aux champs suivants et récupérer les données
    Press Keys    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[76]/div/input     TAB
    Sleep   2s
    
When l'utilisateur clique sur le bouton enregistrer

   # Réduire le zoom de la page à 80%
   Execute JavaScript    document.body.style.zoom = '70%'

    Sleep    1s

   Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/button[13]
   Click Element    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/button[13]
   Sleep    2s

And l'utiloisateur ajoute un autre produit
   Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[3]/div/input
   Input Text    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[3]/div/input    DPT2
   Press Keys    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[3]/div/input   TAB
   Sleep    2s

Given l'utilisateur saisit la quantité à livrer2 dans le champ Quantité

    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[25]/div/input
    Input Text    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[25]/div/input    3.000
    Sleep   2s
When L'utilisateur saisit le Silo2 dans le champ Silo

    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[76]/div/input
    Input Text    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[76]/div/input     S1

    # Utiliser TAB pour passer aux champs suivants et récupérer les données
    Press Keys    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[76]/div/input     TAB
    Sleep   2s

When l'utilisateur clique sur le bouton enregistrer1
    Execute JavaScript    document.body.style.zoom = '60%'

   Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/button[13]
   Click Element    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/button[13]
   Sleep    1s
   Click Element    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/button[13]
   Sleep    10s


When l'utilisateur freme le formulaire d'ajout de produit en cliquand sur le bouton Fermer
      #Execute JavaScript    document.body.style.zoom = '60%'
       Sleep    1s
  #a_3rx4_id  /html/body/div[2]/div[1]/div[10]/div[1]/table/tbody/tr/td[3]/div/span[5]   /html/body/div[2]/div[1]/div[10]/div[1]/table/tbody/tr/td[3]/div/span[5]/span
    Wait Until Element Is Visible   xpath=(//button[@adelianame='BTN_FERMER'])[4]     timeout=10s
    Click Element    xpath=(//button[@adelianame='BTN_FERMER'])[4]
    Sleep  10s

Then Le formulaire d'ajout de produit se ferme et les détails de l'ordre de livraison sont affichés
    Execute JavaScript    document.body.style.zoom = '100%'  # Réinitialiser le zoom à 100%
    Sleep    1s
    Wait Until Page Contains    Détail(s) de l'ordre de livraison    30s
    Log  Détail(s) de l'ordre de livraison

And la liste dans le tableau Détail(s) de l'ordre de livraison se met ajour
    #Execute JavaScript    document.body.style.zoom = '80%'

    Sleep    1s
    ${donnees_tableau}=    Create List

    Wait Until Element Is Visible    xpath=//div[contains(@class, 'dgrid-content')]    timeout=20s

    # Récupérer les en-têtes
    ${entetes}=    Get WebElements    ${TABLE_HADERS_ENTETE}
    ${noms_entetes}=    Create List
    FOR    ${entete}    IN    @{entetes}
        ${texte_entete}=    Get Text    ${entete}
        Append To List    ${noms_entetes}    ${texte_entete}
    END
    Log    En-têtes du tableau: ${noms_entetes}

    # Récupérer les données
    ${lignes}=    Get WebElements    xpath=//div[contains(@class, 'dgrid-row')]

    FOR    ${ligne}    IN    @{lignes}
        ${ligne_id}=    Get Element Attribute    ${ligne}    id
        ${cellules}=    Get WebElements    ${TABLE_CELLS_DET}

        ${ligne_donnees}=    Create Dictionary
        ${textes_cellules}=    Create List

        FOR    ${index}    ${cellule}    IN ENUMERATE    @{cellules}
            ${texte}=    Get Text    ${cellule}
            # Associer chaque valeur avec son en-tête
            Set To Dictionary    ${ligne_donnees}    ${texte_entete}[${index}]=${texte}
        END

        Append To List    ${donnees_tableau}    ${ligne_donnees}
    END

    Log    Données complètes: ${donnees_tableau}
    Should Not Be Empty    ${donnees_tableau}
    Sleep    2s

When L'utilisateur clique sur le bouton 'Valider'
    Execute JavaScript    document.body.style.zoom = '100%'

    Execute JavaScript    document.body.style.zoom = '80%'

    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/button[12]    timeout=20s
    Click Element    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/button[12]
    Sleep    2s

Then Une fenêtre de confirmation affiche les informations suivantes

    Wait Until Element Is Visible        xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[33]/div[3]
    Wait Until Element Is Visible         xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[33]/div[3]/input
    Click Element    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[33]/div[3]/input
    ${texte_a_saisir}    Set Variable    5 - JOURNEE (105)
    Input Text    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[33]/div[3]/input    ${texte_a_saisir}
    Sleep    1s
    Click Element   xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[33]/div[1]/input
    Click Element    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[33]/div[1]/input
    Sleep    3s
    Click Element    xpath=//div[@class='a-combosimplemenuitem'][normalize-space(text())='5 - JOURNEE (105)']

And cliquer sur enregistrer pour enregistrer les informations

   Wait Until Element Is Visible   xpath=(//button[@adelianame='BTN_FERMER'])[4]     timeout=10s
   Click Element    xpath=(//button[@adelianame='BTN_FERMER'])[4]
    Sleep  30s

Then Un document PDF contenant les informations pour l'ordre de livraison s'ouvre dans un nouvel onglet avec le statut validé
    # Get all window handles
    ${handles}=    Get Window Handles

    # Switch to the new tab (last handle in the list)
    Switch Window    ${handles}[-1]

    # Verify we are on the PDF tab
    Wait Until Page Contains Element    //embed[@type='application/pdf']    timeout=30s

    # Optional: Switch back to main window if needed
    Switch Window    ${handles}[1]
    log  L'utilisateur est redirigé vers un formulaire contenant une liste des 'Ordres de livraison'
    Sleep    3s

                               
