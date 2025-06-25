*** Settings ***
Library           RequestsLibrary
Library           Collections

*** Keywords ***
List All Movies
    ${response}=    GET On Session    api    /movies
    RETURN    ${response}

Get Movie By ID
    [Arguments]    ${movie_id}
    ${response}=    GET On Session    api    /movies/${movie_id}
    RETURN    ${response}

Create Movie
    [Arguments]    ${token}    ${movie_data}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    POST On Session    api    /movies    headers=${headers}    json=${movie_data}
    RETURN    ${response}

Delete Movie
    [Arguments]    ${token}    ${movie_id}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    DELETE On Session    api    /movies/${movie_id}    headers=${headers}
    RETURN    ${response}