*** Settings ***
Library           ../variables/test_data.py
Library           Collections
Resource          ../resources/api_keywords.robot
Resource          ../resources/common_keywords.robot
Resource          ../resources/page_objects/home_page.robot
Resource          ../resources/page_objects/login_page.robot
Resource          ../resources/page_objects/movie_detail_page.robot
Resource          ../resources/page_objects/reservations_page.robot
Resource          ../resources/page_objects/seat_selection_page.robot
Test Setup        Setup
Test Teardown     Teardown

*** Test Cases ***
Scenario: View movie details
    Navigate To Home
    Select First Movie
    Wait For Elements State    css=.movie-detail-header    visible    5s
    Wait For Elements State    css=.sessions-container    visible    5s

Scenario: Complete booking flow from start to finish
    ${user}=    Get User Credentials
    Register User Via API    ${user}
    Go To Login Page
    Fill Login Form    ${user['email']}    ${user['password']}
    Submit Login Form
    Verify Logged In Header
    Navigate To Home
    Select First Movie
    Select First Available Session
    Select Available Seats    count=2
    Get Element Count    css=.seat.selected    ==    2
    Click Continue To Payment
    Wait For Elements State    h1:text("Finalizar Compra")    visible    5s
    Click    css=.btn-checkout
    Wait For Elements State    text="Reserva Confirmada!"    visible    10s
    Go To My Reservations
    Wait For Elements State    css=.reservation-card    visible    10s

Scenario: Attempt to select an occupied seat
    Navigate To Home
    Select First Movie
    Select First Available Session
    # Este teste assume que há pelo menos um assento ocupado.
    ${occupied_seat_locator}=    Set Variable    (//button[contains(@class, 'seat occupied')])[1]
    ${count}=    Get Element Count    ${occupied_seat_locator}
    IF    ${count} > 0
        ${states}=    Get Element States    ${occupied_seat_locator}
        Should Contain    ${states}    disabled
    ELSE
        Log    Nenhum assento ocupado foi encontrado para testar. Teste considerado 'pass'.
    END

Scenario: View reservations page
    ${user}=    Get User Credentials
    Register User Via API    ${user}
    Go To Login Page
    Fill Login Form    ${user['email']}    ${user['password']}
    Submit Login Form
    Verify Logged In Header
    Go To My Reservations
    Wait For Elements State    css=.reservations-container    visible    5s