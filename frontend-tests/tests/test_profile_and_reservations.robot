*** Settings ***
Library           ../variables/test_data.py
Resource          ../resources/api_keywords.robot
Resource          ../resources/common_keywords.robot
Resource          ../resources/page_objects/login_page.robot
Resource          ../resources/page_objects/home_page.robot
Resource          ../resources/api_keywords.robot

Test Setup        Setup
Test Teardown     Teardown

*** Test Cases ***
Scenario: Admin user should see the Administration link
    # Este teste assume que um usuário admin (adminuser@example.com) existe no banco de dados.
    Go To Login Page
    Fill Login Form    adminuser@example.com    password123
    Submit Login Form
    Verify Logged In Header
    Wait For Elements State    nav >> text=Administração    visible    5s

Scenario: Regular user should not see the Administration link
    ${user}=    Get User Credentials
    Register User Via API    ${user}
    Go To Login Page
    Fill Login Form    ${user['email']}    ${user['password']}
    Submit Login Form
    Verify Logged In Header
    Wait For Elements State    nav >> text=Administração    hidden    5s

Scenario: Unauthenticated user should be redirected from protected routes
    Go To    ${BASE_URL}/profile
    Get Url    ==    ${BASE_URL}/login
    Go To    ${BASE_URL}/reservations
    Get Url    ==    ${BASE_URL}/login