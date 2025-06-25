*** Settings ***
Library           RequestsLibrary
Library           Collections

*** Keywords ***
List All Theaters
    ${response}=    GET On Session    api    /theaters
    RETURN    ${response}

Get Theater By ID
    [Arguments]    ${theater_id}
    ${response}=    GET On Session    api    /theaters/${theater_id}
    RETURN    ${response}

Create Theater
    [Arguments]    ${token}    ${theater_data}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    POST On Session    api    /theaters    headers=${headers}    json=${theater_data}
    RETURN    ${response}

Delete Theater
    [Arguments]    ${token}    ${theater_id}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    DELETE On Session    api    /theaters/${theater_id}    headers=${headers}
    RETURN    ${response}