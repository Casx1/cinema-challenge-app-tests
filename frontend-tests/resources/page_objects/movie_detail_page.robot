*** Settings ***
Library    Browser

*** Keywords ***
Select First Available Session
    Click    css=.session-times .session-card:first-child .session-button