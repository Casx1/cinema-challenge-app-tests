*** Settings ***
Library           RequestsLibrary
Library           Collections

*** Keywords ***
List All Users
    [Arguments]    ${token}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    GET On Session    api    /users    headers=${headers}
    RETURN    ${response}

Get User By ID
    [Arguments]    ${token}    ${user_id}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    GET On Session    api    /users/${user_id}    headers=${headers}
    RETURN    ${response}

Update User By Admin
    [Arguments]    ${token}    ${user_id}    ${update_data}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    PUT On Session    api    /users/${user_id}    headers=${headers}    json=${update_data}
    RETURN    ${response}

Delete User
    [Arguments]    ${token}    ${user_id}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    DELETE On Session    api    /users/${user_id}    headers=${headers}
    RETURN    ${response}