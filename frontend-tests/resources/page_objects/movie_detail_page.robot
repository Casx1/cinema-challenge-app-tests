*** Settings ***
Library    Browser

*** Keywords ***
Select First Available Session
    Click    xpath=(//a[contains(@class, 'session-button')])[1]