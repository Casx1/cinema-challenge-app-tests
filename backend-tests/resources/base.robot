*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           JSONLibrary
Library           DateTime
Resource          ../keywords/auth_keywords.robot
Resource          ../keywords/movie_keywords.robot
Resource          ../keywords/theater_keywords.robot
Resource          ../keywords/session_keywords.robot
Resource          ../keywords/reservation_keywords.robot
Resource          ../keywords/user_keywords.robot
Resource          ../variables/variables.robot

*** Keywords ***
Setup and Teardown
    RequestsLibrary.Create Session    api    ${BASE_URL}    verify=${True}
    Log In Admin And Set Token
    Log In Regular User And Set Token


Log In Admin And Set Token
    ${token}=    Login User    ${ADMIN_EMAIL}    ${ADMIN_PASSWORD}
    Set Suite Variable    ${ADMIN_TOKEN}    ${token}

Log In Regular User And Set Token
    ${token}=    Login User    ${USER_EMAIL}    ${USER_PASSWORD}
    Set Suite Variable    ${USER_TOKEN}    ${token}