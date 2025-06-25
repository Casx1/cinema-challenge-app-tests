*** Settings ***
Library           RequestsLibrary
Library           Collections

*** Keywords ***
List All Sessions
    ${response}=    GET On Session    api    /sessions
    RETURN    ${response}

Filter Sessions By Movie
    [Arguments]    ${movie_id}
    ${params}=    Create Dictionary    movie=${movie_id}
    ${response}=    GET On Session    api    /sessions    params=${params}
    RETURN    ${response}


Get Session By ID
    [Arguments]    ${session_id}
    ${response}=    GET On Session    api    /sessions/${session_id}
    RETURN    ${response}

Create New Movie Session
    [Arguments]    ${token}    ${session_data}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    POST On Session    api    /sessions    headers=${headers}    json=${session_data}
    RETURN    ${response}

Reset Session Seats
    [Arguments]    ${token}    ${session_id}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    PUT On Session    api    /sessions/${session_id}/reset-seats    headers=${headers}
    RETURN    ${response}