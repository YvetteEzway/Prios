*** Settings ***
Library    SeleniumLibrary    run_on_failure=Capture Page Screenshot
Library    OperatingSystem

*** Keywords ***
Open Login Page
   ${service}=    Evaluate    sys.modules['selenium.webdriver.chrome.service'].Service("${DRIVER_PATH}")  sys, selenium.webdriver.chrome.service
    Open Browser    ${BASE_URL}    Chrome     service=${service}
    Maximize Browser Window

Enter Email
    [Arguments]    ${USERNAME}
    Wait Until Element Is Visible    xpath=//*[@id="i0116"]
    Input Text    xpath=//*[@id="i0116"]    ${USERNAME}

Click Submit Button

    Click Button    xpath=//*[@id="idSIButton9"]

Enter Password
    [Arguments]   ${PASSWORD}
    Wait Until Element Is Visible    xpath=//*[@id="i0118"]
    Input Text    xpath=//*[@id="i0118"]    ${PASSWORD}

Click Login Button
    Click Button    xpath=//*[@id="idSIButton9"]

Click Button2
    Wait Until Element Is Visible    xpath=//*[@id="idSIButton9"]
    Click Element    xpath=//*[@id="idSIButton9"]
    Sleep    20S