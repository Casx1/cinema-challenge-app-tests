*** Settings ***
Resource          ../resources/base.robot
Library           DateTime
Suite Setup       Setup and Teardown

*** Test Cases ***
Cenário: Listar todos os usuários (Admin)
    [Tags]    Admin
    ${response}=    List All Users    ${ADMIN_TOKEN}
    Should Be Equal As Strings    ${response.status_code}    200
    ${data}=    Get Value From Json    ${response.json()}    $.data
    Should Not Be Empty    ${data}

Cenário: Obter detalhes de um usuário por ID (Admin)
    [Tags]    Admin
    ${users_response}=    List All Users    ${ADMIN_TOKEN}
    ${user_id}=    Get Value From Json    ${users_response.json()}    $.data[0]._id
    ${response}=    Get User By ID    ${ADMIN_TOKEN}    ${user_id[0]}
    Should Be Equal As Strings    ${response.status_code}    200
    ${id}=    Get Value From Json    ${response.json()}    $.data._id
    Should Be Equal As Strings    ${id[0]}    ${user_id[0]}

Cenário: Atualizar dados de um usuário (Admin)
    [Tags]    Admin
    ${users_response}=    List All Users    ${ADMIN_TOKEN}
    ${user_id}=    Get Value From Json    ${users_response.json()}    $.data[0]._id
    ${timestamp}=    Get Current Date    result_format=epoch
    ${new_name}=    Set Variable    AdminUpdated ${timestamp}
    &{update_data}=    Create Dictionary    name=${new_name}
    ${response}=    Update User By Admin    ${ADMIN_TOKEN}    ${user_id[0]}    ${update_data}
    Should Be Equal As Strings    ${response.status_code}    200
    ${name}=    Get Value From Json    ${response.json()}    $.data.name
    Should Be Equal As Strings    ${name[0]}    ${new_name}

Cenário: Excluir um usuário (Admin)
    [Tags]    Admin
    ${timestamp}=    Get Current Date    result_format=epoch
    ${email}=    Set Variable    todelete${timestamp}@example.com
    ${create_response}=    Register New User    ToDelete    ${email}    password123
    ${user_id}=    Get Value From Json    ${create_response.json()}    $.data._id
    ${delete_response}=    Delete User    ${ADMIN_TOKEN}    ${user_id[0]}
    Should Be Equal As Strings    ${delete_response.status_code}    200
    ${message}=    Get Value From Json    ${delete_response.json()}    $.message
    Should Be Equal As Strings    ${message[0]}    User removed