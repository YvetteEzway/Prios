*** Settings ***
Library    SeleniumLibrary    run_on_failure=Capture Page Screenshot
Library    OperatingSystem
Library    Collections
Resource    Authentification/login_page.robot
Resource    01.PRIOS_A-M_Ventes/01_AM_Vente.robot

*** Variables ***
${URL}          https://portail-0015.cloud-prios.fr/
${USERNAME}     prios.qa1@prios.fr
${PASSWORD}     Ezw@171M

*** Keywords ***
Open Browser With Options
    [Arguments]    ${url}
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --no-first-run
    Call Method    ${options}    add_argument    --no-default-browser-check
    Call Method    ${options}    add_argument    --disable-default-apps
    Call Method    ${options}    add_argument    --disable-popup-blocking
    ${prefs} =    Evaluate    {'profile.default_content_setting_values.geolocation': 1, 'profile.default_content_setting_values.notifications': 2}
    Call Method    ${options}    add_experimental_option    prefs    ${prefs}
    Create Webdriver    Chrome    options=${options}
    Go To    ${url}
    Maximize Browser Window

*** Test Cases ***
Login And Navigate To Ordres De Livraison
    [Documentation]    Connectez-vous et naviguez vers les ordres de livraison
    Open Browser With Options    ${URL}
    login_page.Input Username    ${USERNAME}
    Capture Page Screenshot    user_name.png
    login_page.Click Login Button
    login_page.Input Password    ${PASSWORD}
    Capture Page Screenshot    password.png
    login_page.Click Login Button
    01_AM_Vente.Given L'utilisateur se trouve sur la page "Plateformes métier"
    01_AM_Vente.When L'utilisateur sélectionne l'option "PRIOS Agriculture" dans la section "Plateformes métier"
    01_AM_Vente.Then Il est redirigé vers une nouvelle page avec les menus de navigation
    01_AM_Vente.Then Les menus de navigation affichent les options suivantes dans les premières "8" options :
    01_AM_Vente.Then Les menus de navigation affichent les options suivantes :
    01_AM_Vente.When L'utilisateur clique sur "PRIOS A-M Ventes"
    01_AM_Vente.Then L'affichage de la page présente les fonctions suivantes dans la première partie de la deuxième colonne :
    01_AM_Vente.Then L'affichage de la page présente les fonctions suivantes dans la seconde partie de la deuxième colonne :
    01_AM_Vente.When L'utilisateur sélectionne "Ordres de livraison" dans la deuxième colonne
    01_AM_Vente.Then Les fonctions suivantes apparaissent dans la première partie de la troisième colonne :
    01_AM_Vente.Then Les fonctions suivantes apparaissent dans la seconde partie de la troisième colonne :
    01_AM_Vente.When L'utilisateur sélectionne Ordres de livraison dans la troisième colonne
    01_AM_Vente.Then L'utilisateur est redirigé vers un formulaire contenant une liste vide d'ordres de livraison
    01_AM_Vente.When L'utilisateur clique sur le bouton "+"
    01_AM_Vente.Then L'utilisateur est redirigé vers un formulaire pour ajouter un nouvel ordre de livraison
    01_AM_Vente.And Si une commande a déjà été créée, alors le formulaire récupère les informations précédemment saisies pour le Preneur d'ordre
    01_AM_Vente.L'utilisateur sélectionne un type d'ordre de livraison : "OL Standard (STD)"
    01_AM_Vente.Then "OL Standard (STD)" est affiché dans le champ
    01_AM_Vente.When L'utilisateur sélectionne un Site : "Z COREAL (ZCO)"
    01_AM_Vente.Then "Z COREAL (ZCO)" est affiché dans le champ
    #01_AM_Vente.And L'utilisateur saisit le nom "dp_test" et effectue la recherche
    #01_AM_Vente.And l'utilusateur clique sur le bouton 'Loupe'
    #01_AM_Vente.And la liste dans le tableau se met ajour
    #01_AM_Vente.And l'utilisateur effectue un double-clic sur un résultat avec "DP_TEST TIERS 13"
    01_AM_Vente.And l'utilisateur saisit le 'Tiers donneur d'ordre' dans le champ
    01_AM_Vente.And l'utilisateur click sur le bouton enregisterer
    01_AM_Vente.Then L'utilisateur est redirigeé vers les details des ordres de livraison
    01_AM_Vente.When l'utilisateur clique sur le bouton + pour ajouter un produit
    01_AM_Vente.Then Un formulaire de sélection de produit s'affiche dans une fenêtre pop-up
    01_AM_Vente.And L'utilisateur saisit le nom Produit dans le champ Produit
    01_AM_Vente.Given l'utilisateur saisit la quantité à livrer dans le champ Quantité
    01_AM_Vente.When L'utilisateur saisit le Silo dans le champ Silo
    01_AM_Vente.When l'utilisateur clique sur le bouton enregistrer
    01_AM_Vente.And l'utiloisateur ajoute un autre produit
    01_AM_Vente.Given l'utilisateur saisit la quantité à livrer2 dans le champ Quantité
    01_AM_Vente.When L'utilisateur saisit le Silo2 dans le champ Silo
    01_AM_Vente.When l'utilisateur clique sur le bouton enregistrer1
    01_AM_Vente.When l'utilisateur freme le formulaire d'ajout de produit en cliquand sur le bouton Fermer
    01_AM_Vente.Then Le formulaire d'ajout de produit se ferme et les détails de l'ordre de livraison sont affichés
    01_AM_Vente.And la liste dans le tableau Détail(s) de l'ordre de livraison se met ajour
    01_AM_Vente.When L'utilisateur clique sur le bouton 'Valider'
    01_AM_Vente.Then Une fenêtre de confirmation affiche les informations suivantes
    01_AM_Vente.And cliquer sur enregistrer pour enregistrer les informations
    01_AM_Vente.Then Un document PDF contenant les informations pour l'ordre de livraison s'ouvre dans un nouvel onglet avec le statut validé
    01_AM_Vente.When l'utilisateur double-clique sur la ligne






















