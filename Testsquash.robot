*** Settings ***
Library           RequestsLibrary

*** Variables ***
${BASE_URL}       https://quality.cloud-prios.fr/
${TOKEN}          votre_token_api
&{HEADERS}        Authorization=Bearer ${TOKEN}

*** Test Cases ***
Lier Test Avec Squash TM
    [Documentation]    Test de liaison avec Squash TM
    Create Session     my_session    ${BASE_URL}    verify=False
    ${response}=       GET On Session    my_session    /votre_endpoint    headers=${HEADERS}
    Should Be Equal As Strings    ${response.status_code}    200
