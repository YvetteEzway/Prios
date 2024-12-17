*** Settings ***
Library    SeleniumLibrary    run_on_failure=Capture Page Screenshot
Library    OperatingSystem
Library    RequestsLibrary
Library    BuiltIn
Library    String
Library    BuiltIn



*** Variables ***

*** keywords ***

When L'utilisateur clique sur le bouton 'Loupe'
   #Wait Until Element Is Visible     xpath=/html/body/div[2]/div[1]/div[7]/div[4]/div[49]/div[1]/div/div[1]
  # Click Element    xptah=//*[@id="a_96l_id"]/div[1]/div/div[1]/table/tbody/tr[1]/td

When l'utilisateur double-clique sur la ligne
    Sleep    2s
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'dgrid-content')]//td    timeout=30s
    Execute Javascript
    ...    var cells = document.evaluate("//div[contains(@class, 'dgrid-content')]//td[contains(text(), 'EARL DP_TEST TIERS 13')]", document, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
    ...    if (cells.snapshotLength > 0) {
    ...        var event = new MouseEvent('dblclick', {
    ...            'view': window,
    ...            'bubbles': true,
    ...            'cancelable': true
    ...        });
    ...        cells.snapshotItem(0).dispatchEvent(event);
    ...    }
    Sleep    2s


