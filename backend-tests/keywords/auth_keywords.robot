*** Settings ***
Library           RequestsLibrary
Library           JSONLibrary

*** Keywords ***
Register New User
    [Arguments]    ${name}    ${email}    ${password}
    ${body}=    Create Dictionary    name=${name}    email=${email}    password=${password}
    ${response}=    POST On Session    api    /auth/register    json=${body}
    RETURN    ${response}

Login User
    [Arguments]    ${email}    ${password}
    ${body}=    Create Dictionary    email=${email}    password=${password}
    ${response}=    POST On Session    api    /auth/login    json=${body}
    Should Be Equal As Strings    ${response.status_code}    200
    ${token}=    Get Value From Json    ${response.json()}    $.data.token
    RETURN    ${token[0]}

Get User Profile
    [Arguments]    ${token}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    GET On Session    api    /auth/me    headers=${headers}
    RETURN    ${response}

Update User Profile
    [Arguments]    ${token}    ${new_name}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${body}=    Create Dictionary    name=${new_name}
    ${response}=    PUT On Session    api    /auth/profile    headers=${headers}    json=${body}
    RETURN    ${response}