*** Settings ***
Library    Browser
Library    OperatingSystem
Library    String
Library    Collections
Resource   ../variables/environment_variables.robot

*** Keywords ***
Setup
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Context    viewport={'width': 1280, 'height': 720}
    New Page       ${BASE_URL}

Teardown
    Close Browser

Go To Login Page
    Go To    ${BASE_URL}/login

Go To Register Page
    Go To    ${BASE_URL}/register