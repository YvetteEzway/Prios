*** Settings ***
Library    SeleniumLibrary    run_on_failure=Capture Page Screenshot
Library    OperatingSystem


*** Keywords ***
Open Login Page
    [Arguments]    ${url}
    Open Browser With Options    ${url}

Input Username
    [Arguments]    ${username}
    Wait Until Element Is Visible    xpath=//*[@id="i0116"]    30s
    Log    Inputting username
    Input Text    xpath=//*[@id="i0116"]    ${username}

Click Login Button
    Wait Until Element Is Visible    xpath=//*[@id="idSIButton9"]    30s
    Log    Clicking login button
    Click Element    xpath=//*[@id="idSIButton9"]

Input Password
    [Arguments]    ${password}
    Wait Until Element Is Visible    xpath=//*[@id="i0118"]    30s
    Log    Inputting password
    Input Text    xpath=//*[@id="i0118"]    ${password}
