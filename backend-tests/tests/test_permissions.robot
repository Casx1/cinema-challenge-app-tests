*** Settings ***
Resource          ../resources/base.robot
Library           DateTime
Suite Setup       Setup and Teardown

*** Test Cases ***
Setup dos Testes de Reserva
    Setup and Teardown
    Log    AVISO: A documentação Swagger para os endpoints de /sessions está incompleta. Resultados de teste obtidos via backend.    level=WARN

Cenário: Tentar obter perfil sem autenticação
    [Tags]    US-AUTH-004
    ${response}=    GET On Session    api    /auth/me    expected_status=401
    Should Be Equal As Strings    ${response.status_code}    401

Cenário: Tentar criar filme sem ser admin
    [Tags]    Admin-Movies
    &{movie_data}=    Create Dictionary    title=Unauthorized Movie    synopsis=...    director=...    genres=${{[ "Test" ]}}    duration=${100}    classification=G    releaseDate=2025-01-01T00:00:00.000Z
    ${headers}=    Create Dictionary    Authorization=Bearer ${USER_TOKEN}
    ${response}=    POST On Session
    ...    api
    ...    /movies    
    ...    json=${movie_data}
    ...    headers=${headers}
    ...    expected_status=403

Cenário: Tentar excluir um filme como usuário comum
    [Tags]    Admin-Movies
    ${movies_response}=    List All Movies
    ${movie_id}=    Get Value From Json    ${movies_response.json()}    $.data[0]._id
    ${headers}=    Create Dictionary    Authorization=Bearer ${USER_TOKEN}
    ${response}=    DELETE On Session
    ...    api
    ...    /movies/${movie_id[0]}
    ...    headers=${headers}
    ...    expected_status=403

Cenário: Tentar criar uma sessão como usuário comum
    [Tags]    Admin-Sessions
    &{session_data}=    Create Dictionary    movie=x    theater=x    datetime=x    fullPrice=x    halfPrice=x
    ${headers}=    Create Dictionary    Authorization=Bearer ${USER_TOKEN}
    ${response}=    POST On Session
    ...    api
    ...    /sessions
    ...    json=${session_data}
    ...    headers=${headers}
    ...    expected_status=403

Cenário: Tentar criar sessão para filme inexistente
    [Tags]    Admin-Sessions
    ${theaters_response}=    List All Theaters
    ${theater_id}=    Get Value From Json    ${theaters_response.json()}    $.data[0]._id
    ${datetime}=    Get Current Date    increment=1 day    result_format=%Y-%m-%dT18:00:00.000Z
    &{session_data}=    Create Dictionary
    ...    movie=60d0fe4f5311236168a109ff
    ...    theater=${theater_id[0]}
    ...    datetime=${datetime}
    ...    fullPrice=${30}
    ...    halfPrice=${15}
    ${headers}=    Create Dictionary    Authorization=Bearer ${ADMIN_TOKEN}
    ${response}=    POST On Session
    ...    api
    ...    /sessions
    ...    json=${session_data}
    ...    headers=${headers}
    ...    expected_status=404
    ${message}=    Get Value From Json    ${response.json()}    $.message
    Should Be Equal As Strings    ${message[0]}    Movie not found

Cenário: Tentar criar reserva sem autenticação
    [Tags]    US-RESERVE-001
    ${empty_body}=    Create Dictionary
    ${response}=    POST On Session    api    /reservations    json=${empty_body}    expected_status=401
    Should Be Equal As Strings    ${response.status_code}    401

Cenário: Tentar criar sala como usuário comum
    [Tags]    Admin-Theaters
    &{theater_data}=    Create Dictionary    name=Unauthorized Theater    capacity=${100}    type=standard
    ${headers}=    Create Dictionary    Authorization=Bearer ${USER_TOKEN}
    ${response}=    POST On Session
    ...    api
    ...    /theaters
    ...    json=${theater_data}
    ...    headers=${headers}
    ...    expected_status=403

Cenário: Tentar listar usuários como usuário comum
    [Tags]    Admin-Users
    ${headers}=    Create Dictionary    Authorization=Bearer ${USER_TOKEN}
    ${response}=    GET On Session
    ...    api
    ...    /users
    ...    headers=${headers}
    ...    expected_status=403