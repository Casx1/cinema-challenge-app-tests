*** Settings ***
Resource          ../resources/base.robot
Library           DateTime
Suite Setup       Setup and Teardown

*** Test Cases ***
Cenário: Listar todas as salas (público)
    [Tags]    N/A
    ${response}=    List All Theaters
    Should Be Equal As Strings    ${response.status_code}    200
    ${data}=    Get Value From Json    ${response.json()}    $.data
    Should Not Be Empty    ${data}

Cenário: Obter detalhes de uma sala por ID (público)
    [Tags]    N/A
    ${theaters_response}=    List All Theaters
    ${theater_id}=    Get Value From Json    ${theaters_response.json()}    $.data[0]._id
    ${response}=    Get Theater By ID    ${theater_id[0]}
    Should Be Equal As Strings    ${response.status_code}    200
    ${id}=    Get Value From Json    ${response.json()}    $.data._id
    Should Be Equal As Strings    ${id[0]}    ${theater_id[0]}

Cenário: Tentar obter sala com ID inexistente
    [Tags]    N/A
    ${response}=    GET On Session
    ...    api
    ...    /theaters/60d0fe4f5311236168a109ff
    ...    expected_status=404
    ${message}=    Get Value From Json    ${response.json()}    $.message
    Should Be Equal As Strings    ${message[0]}    Theater not found

Cenário: Criar nova sala (Admin)
    [Tags]    Admin
    ${timestamp}=    Get Current Date    result_format=epoch
    &{theater_data}=    Create Dictionary    name=New Theater ${timestamp}    capacity=${150}    type=IMAX
    ${response}=    Create Theater    ${ADMIN_TOKEN}    ${theater_data}
    Should Be Equal As Strings    ${response.status_code}    201
    ${name}=    Get Value From Json    ${response.json()}    $.data.name
    Should Be Equal As Strings    ${name[0]}    New Theater ${timestamp}

Cenário: Excluir uma sala (Admin)
    [Tags]    Admin
    ${timestamp}=    Get Current Date    result_format=epoch
    &{theater_data}=    Create Dictionary    name=To Be Deleted ${timestamp}    capacity=${100}    type=standard
    ${create_response}=    Create Theater    ${ADMIN_TOKEN}    ${theater_data}
    ${theater_id}=    Get Value From Json    ${create_response.json()}    $.data._id
    ${delete_response}=    Delete Theater    ${ADMIN_TOKEN}    ${theater_id[0]}
    Should Be Equal As Strings    ${delete_response.status_code}    200
    ${message}=    Get Value From Json    ${delete_response.json()}    $.message
    Should Be Equal As Strings    ${message[0]}    Theater removed