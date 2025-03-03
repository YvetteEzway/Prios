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
${FIELD_ID}          xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[3]/div/input
${FIELD_ID2}         xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[4]/div/input
${PARENT_XPATH}      xpath=//div[@class='dijitReset dijitInputField dijitInputContainer']
${code_donneur_ordre}         84_TEST13


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
    Wait Until Page Contains    Prios    5s
    Capture Page Screenshot

Then Les menus de navigation affichent :

    [Documentation]    Vérifie que les 8 options spécifiées sont présentes dans le menu.
    # Ouvrir l'onglet contenant les options
    ${handles} =    Get Window Handles
    Switch Window    ${handles}[-1]
    Sleep    5s
    Capture Page Screenshot


When L'utilisateur clique sur "PRIOS A-M Ventes"
    [Documentation]    Sélectionne l'option "PRIOS A-M Ventes" sur la page.
    Execute JavaScript    document.evaluate("//*[contains(text(), 'PRIOS A-M Ventes')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);

    Wait Until Element Is Visible    xpath=//*[contains(text(), 'PRIOS A-M Ventes')]    30s
    Click Element    xpath=//*[contains(text(), 'PRIOS A-M Ventes')]

    Sleep    3s
    Capture Page Screenshot

When L'utilisateur sélectionne "Ordres de livraison" dans la deuxième colonne

    [Documentation]    Sélectionne l'option "Ordres de livraison" sur la page.
    Execute JavaScript    document.evaluate("(//*[contains(text(), 'Ordres de livraison')])[1]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    Execute JavaScript    document.evaluate("(//*[contains(text(), 'Ordres de livraison')])[1]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()

    Sleep    2s
    Capture Page Screenshot

When L'utilisateur sélectionne Ordres de livraison dans la troisième colonne

    [Documentation]    Sélectionne l'option "Ordres de livraison troisième colonne " sur la page.
    Execute JavaScript    document.evaluate("(//*[contains(text(), 'Ordres de livraison')])[2]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    Execute JavaScript    document.evaluate("(//*[contains(text(), 'Ordres de livraison')])[2]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()

    Sleep    2s
    Capture Page Screenshot

When L'utilisateur clique sur le bouton "+"
    [Documentation]    Sélectionne l'option "le bouton +" sur la page.
    Wait Until Element Is Visible    xpath=//img[contains(@class, 'a-image') and contains(@src, 'CB8CF15EBC54179FBC57E708D9C763D9')]    timeout=30s

    Execute JavaScript    document.evaluate("//img[contains(@class, 'a-image') and contains(@src, 'CB8CF15EBC54179FBC57E708D9C763D9')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    Click Element    xpath=//img[contains(@class, 'a-image') and contains(@src, 'CB8CF15EBC54179FBC57E708D9C763D9')]
    Sleep    3s
    Capture Page Screenshot

L'utilisateur sélectionne un type d'ordre de livraison : "OL Standard (STD)"

    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[7]/div[1]/input    60s
    Click Element    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[7]/div[1]/input
    Click Element    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[7]/div[1]/input

    Wait Until Element Is Visible    xpath=(//input[@value='▼ '])[7]    30s
    Click Element                    xpath=(//input[@value='▼ '])[7]
    Sleep    3s

    # Attendre que la liste déroulante soit visible
    Wait Until Element Is Visible    xpath=//div[@class='dijitPopup dijitComboBoxMenuPopup' and not(contains(@style, 'display: none'))]    60s

    # Cliquer sur l'élément OL Standard (STD)
    Click Element    xpath=//div[@class='a-combosimplemenuitem'][normalize-space(text())='OL Standard (STD)']
    Capture Page Screenshot

When L'utilisateur sélectionne un Site : "Z COREAL (ZCO)"
     Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[10]/div[1]/input    60s
     Click Element                    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[10]/div[1]/input
     Click Element                    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[10]/div[1]/input

     Wait Until Element Is Visible    xpath=(//input[@value='▼ '])[8]    30s
     Click Element                    xpath=(//input[@value='▼ '])[8]
     Sleep    5s

    # Cliquer sur l'élément Z COREAL (ZCO)
    Wait Until Element Is Visible    xpath=//div[@class='a-combosimplemenuitem'][normalize-space(text())='Z COREAL (ZCO)']      30s
    Click Element    xpath=//div[@class='a-combosimplemenuitem'][normalize-space(text())='Z COREAL (ZCO)']
    Capture Page Screenshot

And l'utilisateur saisit le 'Tiers donneur d'ordre' dans le champ
   # D'abord saisir le code donneur d'ordre
   Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[13]/div/input
   Input Text    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[13]/div/input    ${code_donneur_ordre}

   # Utiliser TAB pour passer aux champs suivants et récupérer les données
   Press Keys    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/div[1]/div[3]/div/div/div[13]/div/input    TAB

   # Attendre que les autres champs soient remplis automatiquement
   Sleep    2s
And l'utilisateur click sur le bouton enregisterer
    # Faire défiler jusqu'au bouton d'enregistrement avec un offset vertical
    Execute JavaScript    document.evaluate("/html/body/div[2]/div[1]/div[8]/div[4]/button[12]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView({behavior: 'smooth', block: 'center'});
    Sleep    2s
    # Attendre et cliquer sur le bouton
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/button[12]    10s
    Click Element    xpath=/html/body/div[2]/div[1]/div[8]/div[4]/button[12]

When l'utilisateur clique sur le bouton + pour ajouter un produit

    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[3]/div[1]/div[1]/div[1]/table/tbody/tr[1]/td/img
    Click Element    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/div[3]/div[1]/div[1]/div[1]/table/tbody/tr[1]/td/img

And L'utilisateur saisit le nom Produit dans le champ Produit

   Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[3]/div/input
   Input Text    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[3]/div/input    DPT1
   Press Keys    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[3]/div/input   TAB

Given l'utilisateur saisit la quantité à livrer dans le champ Quantité

    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[25]/div/input
    Input Text    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[25]/div/input    1.500
When L'utilisateur saisit le Silo dans le champ Silo

    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[76]/div/input
    Input Text    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[76]/div/input     S1

    # Utiliser TAB pour passer aux champs suivants et récupérer les données
    Press Keys    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[76]/div/input     TAB
    Sleep   2s

When l'utilisateur clique sur le bouton enregistrer

   Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/button[13]
   Click Element    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/button[13]
   Sleep    2s

And l'utiloisateur ajoute un autre produit
   Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[3]/div/input
   Input Text    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[3]/div/input    DPT2
   Press Keys    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[3]/div/input   TAB

Given l'utilisateur saisit la quantité à livrer2 dans le champ Quantité

    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[25]/div/input
    Input Text    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[25]/div/input    3.000

When L'utilisateur saisit le Silo2 dans le champ Silo

    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[76]/div/input
    Input Text    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[76]/div/input     S1
    # Utiliser TAB pour passer aux champs suivants et récupérer les données
    Press Keys    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/div[1]/div[3]/div[1]/div/div[76]/div/input     TAB
    Sleep   2s

When l'utilisateur clique sur le bouton enregistrer1

   Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/button[13]
   Click Element    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/button[13]
   Sleep    1s
   Click Element    xpath=/html/body/div[2]/div[1]/div[10]/div[4]/button[13]

When l'utilisateur freme le formulaire d'ajout de produit en cliquand sur le bouton Fermer
    Wait Until Element Is Visible   xpath=(//button[@adelianame='BTN_FERMER'])[4]     timeout=10s
    Click Element    xpath=(//button[@adelianame='BTN_FERMER'])[4]

When L'utilisateur clique sur le bouton 'Valider'
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/div[9]/div[4]/button[12]    timeout=10s
    Click Element       xpath=/html/body/div[2]/div[1]/div[9]/div[4]/button[12]
