*** Settings ***
Library           ../variables/test_data.py
Resource          ../resources/common_keywords.robot
Resource          ../resources/page_objects/login_page.robot
Resource          ../resources/page_objects/home_page.robot
Resource          ../resources/page_objects/profile_page.robot
Resource          ../resources/api_keywords.robot
Test Setup        Setup
Test Teardown     Teardown

*** Test Cases ***
Scenario: Register with valid data
    Go To Register Page
    ${user}=    Get User Credentials
    Fill Text    id=name               ${user['name']}
    Fill Text    id=email              ${user['email']}
    Fill Text    id=password           ${user['password']}
    Fill Text    id=confirmPassword    ${user['password']}
    Click    button[type=submit]
    Verify Registration Success

Scenario: Attempt to register with mismatching passwords
    Go To Register Page
    ${user}=    Get User Credentials
    Fill Text    id=name               ${user['name']}
    Fill Text    id=email              ${user['email']}
    Fill Text    id=password           ${user['password']}
    Fill Text    id=confirmPassword    wrongpassword
    Click    button[type=submit]
    Wait For Elements State    text="As senhas não coincidem."    visible    5s

Scenario: Login with valid credentials
    ${user}=    Get User Credentials
    Register User Via API    ${user}
    Go To Login Page
    Fill Login Form    ${user['email']}    ${user['password']}
    Submit Login Form
    Verify Logged In Header

Scenario: Attempt login with incorrect password
    ${user}=    Get User Credentials
    Register User Via API    ${user}
    Go To Login Page
    Fill Login Form    ${user['email']}    some_wrong_password
    Submit Login Form
    Verify Login Has Failed

Scenario: Update user name in profile
    ${user}=    Get User Credentials
    Register User Via API    ${user}
    Go To Login Page
    Fill Login Form    ${user['email']}    ${user['password']}
    Submit Login Form
    Verify Logged In Header
    Go To Profile
    Wait For Elements State    h1:text("Meu Perfil")    visible    5s
    ${new_name}=    Catenate    SEPARATOR=    ${user['name']}    Atualizado
    Update User Name    ${new_name}
    Verify Name Update    ${new_name}

Scenario: Logout from account
    ${user}=    Get User Credentials
    Register User Via API    ${user}
    Go To Login Page
    Fill Login Form    ${user['email']}    ${user['password']}
    Submit Login Form
    Verify Logged In Header
    Logout
    Verify Logged Out Header