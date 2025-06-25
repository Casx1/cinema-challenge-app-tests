*** Settings ***
Resource          ../resources/base.robot
Library           DateTime
Suite Setup       Setup and Teardown

*** Test Cases ***
Setup dos Testes de Reserva
    Setup and Teardown
    Log    AVISO: A documentação Swagger para os endpoints de /sessions está incompleta. Resultados de testes obtidos via backend.    level=WARN

Cenário: Listar todas as sessões (público)
    [Tags]    US-SESSION-001
    ${response}=    List All Sessions
    Should Be Equal As Strings    ${response.status_code}    200
    ${data}=    Get Value From Json    ${response.json()}    $.data
    Should Not Be Empty    ${data}

Cenário: Filtrar sessões por filme
    [Tags]    US-SESSION-001
    ${movies_response}=    List All Movies
    ${movie_id}=    Get Value From Json    ${movies_response.json()}    $.data[0]._id
    ${response}=    Filter Sessions By Movie    ${movie_id[0]}
    Should Be Equal As Strings    ${response.status_code}    200
    ${sessions}=    Get Value From Json    ${response.json()}    $.data
    FOR    ${session}    IN    @{sessions[0]}
        Should Be Equal As Strings    ${session['movie']['_id']}    ${movie_id[0]}
    END

Cenário: Obter detalhes de uma sessão por ID
    [Tags]    US-SESSION-001
    ${sessions_response}=    List All Sessions
    ${session_id}=    Get Value From Json    ${sessions_response.json()}    $.data[0]._id
    ${response}=    Get Session By ID    ${session_id[0]}
    Should Be Equal As Strings    ${response.status_code}    200
    ${id}=    Get Value From Json    ${response.json()}    $.data._id
    Should Be Equal As Strings    ${id[0]}    ${session_id[0]}

Cenário: Criar nova sessão (Admin)
    [Tags]    Admin
    ${movies_response}=    List All Movies
    ${movie_id}=    Get Value From Json    ${movies_response.json()}    $.data[0]._id
    ${theaters_response}=    List All Theaters
    ${theater_id}=    Get Value From Json    ${theaters_response.json()}    $.data[0]._id
    ${datetime}=    Get Current Date    increment=1 day    result_format=%Y-%m-%dT18:00:00.000Z
    &{session_data}=    Create Dictionary
    ...    movie=${movie_id[0]}
    ...    theater=${theater_id[0]}
    ...    datetime=${datetime}
    ...    fullPrice=${30}
    ...    halfPrice=${15}
    ${response}=    Create New Movie Session    ${ADMIN_TOKEN}    ${session_data}
    Should Be Equal As Strings    ${response.status_code}    201
    ${movie_out}=    Get Value From Json    ${response.json()}    $.data.movie
    Should Be Equal As Strings    ${movie_out[0]}    ${movie_id[0]}

Cenário: Resetar assentos de uma sessão (Admin)
    [Tags]    Admin-Sessions
    ${sessions_response}=    List All Sessions
    ${session_id}=    Get Value From Json    ${sessions_response.json()}    $.data[0]._id
    ${response}=    Reset Session Seats    ${ADMIN_TOKEN}    ${session_id[0]}
    Should Be Equal As Strings    ${response.status_code}    200
    ${seats}=    Get Value From Json    ${response.json()}    $.data.seats
    FOR    ${seat}    IN    @{seats[0]}
        Should Be Equal As Strings    ${seat['status']}    available
    END