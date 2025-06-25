*** Settings ***
Resource          ../resources/base.robot
Suite Setup       Setup and Teardown

*** Test Cases ***
Cenário: Registrar novo usuário com dados válidos
    [Tags]    US-AUTH-001
    ${timestamp}=    Get Current Date    result_format=epoch
    ${response}=    Register New User    Test User ${timestamp}    testuser${timestamp}@example.com    password123
    Should Be Equal As Strings    ${response.status_code}    201
    ${token}=    Get Value From Json    ${response.json()}    $.data.token
    Should Not Be Empty    ${token}

Cenário: Tentar registrar usuário com e-mail já existente
    [Tags]    US-AUTH-001
    ${body}=    Create Dictionary    name=Another User    email=${USER_EMAIL}    password=password123
    ${response}=    POST On Session
    ...    api
    ...    /auth/register
    ...    json=${body}
    ...    expected_status=400

    ${message}=    Get Value From Json    ${response.json()}    $.message
    Should Be Equal As Strings    ${message[0]}    User already exists

Cenário: Realizar login com credenciais válidas
    [Tags]    US-AUTH-002
    ${token}=    Login User    ${USER_EMAIL}    ${USER_PASSWORD}
    Should Not Be Empty    ${token}

Cenário: Tentar realizar login com senha incorreta
    [Tags]    US-AUTH-002
    ${body}=    Create Dictionary    email=${USER_EMAIL}    password=wrongpassword
    ${response}=    POST On Session    api    /auth/login    json=${body}    expected_status=401
    ${message}=    Get Value From Json    ${response.json()}    $.message
    Should Be Equal As Strings    ${message[0]}    Invalid email or password

Cenário: Obter perfil do usuário autenticado
    [Tags]    US-AUTH-004
    ${response}=    Get User Profile    ${USER_TOKEN}
    Should Be Equal As Strings    ${response.status_code}    200
    ${email}=    Get Value From Json    ${response.json()}    $.data.email
    Should Be Equal As Strings    ${email[0]}    ${USER_EMAIL}

Cenário: Atualizar nome do perfil do usuário
    [Tags]    US-AUTH-004
    ${timestamp}=    Get Current Date    result_format=epoch
    ${new_name}=    Set Variable    Updated Name ${timestamp}
    ${response}=    Update User Profile    ${USER_TOKEN}    ${new_name}
    Should Be Equal As Strings    ${response.status_code}    200
    ${updated_name}=    Get Value From Json    ${response.json()}    $.data.name
    Should Be Equal As Strings    ${updated_name[0]}    ${new_name}