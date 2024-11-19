*** Settings ***
Library    SeleniumLibrary    run_on_failure=Capture Page Screenshot
Library    OperatingSystem
Library    RequestsLibrary


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
    Wait Until Page Contains    Prios    100s

Then Les menus de navigation affichent les options suivantes dans les premières "8" options :

    [Documentation]    Vérifie que les 8 options spécifiées sont présentes dans le menu.
    # Ouvrir l'onglet contenant les options (assurez-vous que vous êtes dans le bon onglet)
    ${handles} =    Get Window Handles
    Switch Window    ${handles}[-1]
    Sleep    100s

    # Vérifier chaque option avec un défilement si nécessaire
    FOR    ${option}    IN    @{OPTIONS}
        Log    Vérification de l'option : ${option}

        # Faire défiler l'option dans la vue si nécessaire
        Execute JavaScript    document.evaluate("//*[contains(text(), '${option}')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);

        # Attendre que l'option soit visible après le défilement
        Wait Until Element Is Visible    xpath=//*[contains(text(), '${option}')]    timeout=60s

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
        Wait Until Element Is Visible    xpath=//*[contains(text(), '${option2}')]    timeout=60s

        # Vérifier que l'option est présente
        ${element_found} =    Execute JavaScript    return document.evaluate("//*[contains(text(), '${option2}')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
        Run Keyword If    '${element_found}' != 'None'    Log    Option ${option2} trouvée.
        Run Keyword If    '${element_found}' == 'None'    Fail    Option ${option2} non trouvée.
    END

When L'utilisateur clique sur "PRIOS A-M Ventes"
    [Documentation]    Sélectionne l'option "PRIOS A-M Ventes" sur la page.
    Execute JavaScript    document.evaluate("//*[contains(text(), 'PRIOS A-M Ventes')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);

    Wait Until Element Is Visible    xpath=//*[contains(text(), 'PRIOS A-M Ventes')]    60s
    Click Element    xpath=//*[contains(text(), 'PRIOS A-M Ventes')]

    Sleep    60s

Then L'affichage de la page présente les fonctions suivantes dans la première partie de la deuxième colonne :

   FOR    ${option3}    IN    @{2emeCOL}
        Log    Vérification de l'option : ${option3}

        # Faire défiler l'option dans la vue si nécessaire
        Execute JavaScript    document.evaluate("//*[contains(text(), '${option3}')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);

        # Attendre que l'option soit visible après le défilement
        Wait Until Element Is Visible    xpath=//*[contains(text(), '${option3}')]    timeout=60s

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
        Wait Until Element Is Visible    xpath=//*[contains(text(), '${option4}')]    timeout=60s

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

    Sleep    30s

Then Les fonctions suivantes apparaissent dans la première partie de la troisième colonne :

    FOR    ${option5}    IN    @{3emeCOL}
        Log    Vérification de l'option : ${option5}

        # Faire défiler l'option dans la vue si nécessaire
        Execute JavaScript    document.evaluate("//*[contains(text(), '${option5}')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);

        # Attendre que l'option soit visible après le défilement
        Wait Until Element Is Visible    xpath=//*[contains(text(), '${option5}')]    timeout=60s

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
    Wait Until Element Is Visible    xpath=//*[contains(@class, 'dijitDialogTitle') and contains(text(), 'Ordres de livraison - Sté PRIOS - Etablissement CARQUEFOU')]    timeout=60s

Then L'utilisateur est redirigé vers un formulaire contenant une liste vide d'ordres de livraison

    [Documentation]    Vérifie que la nouvelle page contient le texte spécifique pour confirmer la redirection.
    Wait Until Page Contains    Ordres de livraison - Sté PRIOS - Etablissement CARQUEFOU    60s
    Log    Le texte "Ordres de livraison - Sté PRIOS - Etablissement CARQUEFOU" est bien présent sur la page.
When L'utilisateur clique sur le bouton "+"
    [Documentation]    Sélectionne l'option "le bouton +" sur la page.
    Wait Until Element Is Visible    xpath=//img[contains(@class, 'a-image') and contains(@src, 'CB8CF15EBC54179FBC57E708D9C763D9')]    timeout=30s

    Execute JavaScript    document.evaluate("//img[contains(@class, 'a-image') and contains(@src, 'CB8CF15EBC54179FBC57E708D9C763D9')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    Sleep    30s
    Click Element    xpath=//img[contains(@class, 'a-image') and contains(@src, 'CB8CF15EBC54179FBC57E708D9C763D9')]
    Sleep    60s
Then L'utilisateur est redirigé vers un formulaire pour ajouter un nouvel ordre de livraison
    [Documentation]    Vérifie que la nouvelle page contient le texte spécifique pour confirmer la redirection.
    Wait Until Page Contains    Ordre de livraison [C] - Sté PRIOS - Etablissement CARQUEFOU    60s
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
    Wait Until Element Is Visible    ${FIELD_ID2}    timeout=30s

    # Obtenir la valeur du champ
    ${field_value1}=    Get Value   ${FIELD_ID2}
    Should Not Be Empty    ${field_value1}    msg=Le champ a une valeur.
    Log    Le champ a une valeur.

    # Vérifier que le champ est grisé (readonly)
    ${readonly}=    Get Element Attribute    ${FIELD_ID2}    readonly
    Should Be Equal As Strings    ${readonly}    true    msg=Le champ est en lecture seule.
    Log   Le champ est grisé et en mode lecture seule.

 L'utilisateur sélectionne un type d'ordre de livraison : "OL Standard (STD)"

    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[7]/div[1]/input    100s
    Click Element    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[7]/div[1]/input
    Click Element    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[7]/div[1]/input

    Wait Until Element Is Visible    xpath=(//input[@value='▼ '])[7]    100s
    Click Element                    xpath=(//input[@value='▼ '])[7]
    Sleep    30s

    # Attendre que la liste déroulante soit visible
    Wait Until Element Is Visible    xpath=//div[@class='dijitPopup dijitComboBoxMenuPopup' and not(contains(@style, 'display: none'))]    100s

# Cliquer sur l'élément OL Standard (STD)
    Click Element    xpath=//div[@class='a-combosimplemenuitem'][normalize-space(text())='OL Standard (STD)']
    Capture Page Screenshot

Then "OL Standard (STD)" est affiché dans le champ
    Wait Until Element Is Visible    ${FIELD-ID4}    timeout=100s

    # Vérifier que le champ a une valeur non vide
    ${field_value}=    Get Value    ${FIELD-ID4}
    Should Not Be Empty    ${field_value}    msg=Le champ type d'ordre de livraison a une valeur 'OL Standard (STD)' '.
    Log    Le champ type d'ordre de livraison a une valeur 'OL Standard (STD)'.

When L'utilisateur sélectionne un Site : "Z COREAL (ZCO)"
     Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[10]/div[1]/input    20s
     Click Element                    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[10]/div[1]/input
     Click Element                    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[10]/div[1]/input

     Wait Until Element Is Visible    xpath=(//input[@value='▼ '])[8]    250s
     Click Element                    xpath=(//input[@value='▼ '])[8]
     Sleep    20s

     # Attendre que la liste déroulante soit visible
     #Wait Until Element Is Visible    xpath=//div[@id='widget_a_4ik_id' and contains(@class, 'dijitComboBox') and not(contains(@style, 'visibility: hidden'))]     60s

# Cliquer sur l'élément
    Click Element    xpath=//div[@class='a-combosimplemenuitem'][normalize-space(text())='Z COREAL (ZCO)']
    Capture Page Screenshot

Then "Z COREAL (ZCO)" est affiché dans le champ

     Wait Until Element Is Visible    ${FIELD-ID5}    timeout=20s

    # Vérifier que le champ a une valeur non vide
    ${field_value}=    Get Value    ${FIELD-ID5}
    Should Not Be Empty    ${field_value}    msg=Le champ Site a une valeur 'Z COREAL (ZCO) '.
    Log    Le champ Site a une valeur 'Z COREAL (ZCO)'.

When L'utilisateur recherche le 'Tiers donneur d'ordre' en cliquant sur le bouton 'loupe'
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/button[2]

    Click Element    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/button[2]
    Sleep    10s
And L'utilisateur saisit le nom "dp_test" et effectue la recherche
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[14]/div
    Click Element       xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[14]/div
    Input Text          xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[14]/div/input    ${code_donneur_ordre}
