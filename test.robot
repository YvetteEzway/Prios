*** Settings ***
Library    RequestsLibrary

*** Variables ***
${BASE_URL}      https://quality.cloud-prios.fr/squash/api/rest/latest
${USERNAME}      Prios
${PASSWORD}      123456789
${AUTH_HEADER}   Basic ${base64_auth}  # Remplacez ${base64_auth} par la chaîne encodée obtenue du script Python

*** Test Cases ***
Authentifier Et Vérifier Réponse
    [Documentation]    Authentifie l'utilisateur et vérifie la réponse
    [Tags]    api
    Create Session    squash    ${BASE_URL}    headers=${headers}
    ${auth_response}=    POST On Session    squash    /auth
    Should Be Equal As Numbers    ${auth_response.status_code}    200
    Log    ${auth_response.json()}

*** Keywords ***
Create Headers
    ${auth_header}=    Create Dictionary    Authorization=${AUTH_HEADER}
    [Return]    ${auth_header}
