*** Settings ***
Library           RequestsLibrary
Library           Collections

*** Keywords ***
Create Reservation
    [Arguments]    ${token}    ${session_id}    ${seats}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${body}=    Create Dictionary    session=${session_id}    seats=${seats}
    ${response}=    POST On Session    api    /reservations    headers=${headers}    json=${body}
    RETURN    ${response}

List My Reservations
    [Arguments]    ${token}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    GET On Session    api    /reservations/me    headers=${headers}
    RETURN    ${response}

Cancel Reservation
    [Arguments]    ${token}    ${reservation_id}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    DELETE On Session    api    /reservations/${reservation_id}    headers=${headers}
    RETURN    ${response}