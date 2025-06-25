*** Settings ***
Resource          ../resources/base.robot
Library           DateTime
Suite Setup       Setup and Teardown

*** Test Cases ***
Cenário: Listar todos os filmes (público)
    [Tags]    US-MOVIE-001
    ${response}=    List All Movies
    Should Be Equal As Strings    ${response.status_code}    200
    ${data}=    Get Value From Json    ${response.json()}    $.data
    Should Not Be Empty    ${data}

Cenário: Obter detalhes de um filme por ID (público)
    [Tags]    US-MOVIE-002
    ${movies_response}=    List All Movies
    ${movie_id}=    Get Value From Json    ${movies_response.json()}    $.data[0]._id
    ${response}=    Get Movie By ID    ${movie_id[0]}
    Should Be Equal As Strings    ${response.status_code}    200
    ${id}=    Get Value From Json    ${response.json()}    $.data._id
    Should Be Equal As Strings    ${id[0]}    ${movie_id[0]}

Cenário: Tentar obter filme com ID inexistente
    [Tags]    US-MOVIE-002
    ${response}=    GET On Session
    ...    api
    ...    /movies/60d0fe4f5311236168a109ff
    ...    expected_status=404

    ${message}=    Get Value From Json    ${response.json()}    $.message
    Should Be Equal As Strings    ${message[0]}    Movie not found

Cenário: Criar novo filme (Admin)
    [Tags]    Admin
    ${timestamp}=    Get Current Date    result_format=epoch
    &{movie_data}=    Create Dictionary
    ...    title=New Movie ${timestamp}
    ...    synopsis=A great movie synopsis.
    ...    director=A Famous Director
    ...    genres=${{[ "Action", "Sci-Fi" ]}}
    ...    duration=${120}
    ...    classification=PG-13
    ...    releaseDate=2025-01-01T00:00:00.000Z
    ${response}=    Create Movie    ${ADMIN_TOKEN}    ${movie_data}
    Should Be Equal As Strings    ${response.status_code}    201
    ${title}=    Get Value From Json    ${response.json()}    $.data.title
    Should Be Equal As Strings    ${title[0]}    New Movie ${timestamp}

Cenário: Excluir um filme (Admin)
    [Tags]    Admin
    ${timestamp}=    Get Current Date    result_format=epoch
    &{movie_data}=    Create Dictionary
    ...    title=To Be Deleted ${timestamp}
    ...    synopsis=Synopsis for deletion.
    ...    director=Director
    ...    genres=${{[ "Drama" ]}}
    ...    duration=${90}
    ...    classification=R
    ...    releaseDate=2025-01-01T00:00:00.000Z
    ${create_response}=    Create Movie    ${ADMIN_TOKEN}    ${movie_data}
    ${movie_id}=    Get Value From Json    ${create_response.json()}    $.data._id
    ${delete_response}=    Delete Movie    ${ADMIN_TOKEN}    ${movie_id[0]}
    Should Be Equal As Strings    ${delete_response.status_code}    200
    ${message}=    Get Value From Json    ${delete_response.json()}    $.message
    Should Be Equal As Strings    ${message[0]}    Movie removed