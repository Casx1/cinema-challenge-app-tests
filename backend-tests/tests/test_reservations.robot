*** Settings ***
Resource          ../resources/base.robot
Suite Setup       Setup dos Testes de Reserva 
Test Setup        Get Available Session And Seats

*** Keywords ***

Setup dos Testes de Reserva
    Setup and Teardown
    Log    AVISO: A documentação Swagger para os endpoints de /reservations está incompleta. Resultados de testes obtidos via backend.    level=WARN

Get Available Session And Seats
    ${response}=    List All Sessions
    ${sessions}=    Get Value From Json    ${response.json()}    $.data
    FOR    ${session}    IN    @{sessions[0]}
        ${available_seats}=    Get Available Seats From Session    ${session}
        IF    len($available_seats) >= 2
            Set Test Variable    ${SESSION_ID}    ${session['_id']}
            &{seat1_dict}=    Create Dictionary
            ...    row=${available_seats[0]['row']}
            ...    number=${available_seats[0]['number']}
            ...    type=full
            Set Test Variable    ${SEAT_TO_BOOK_1}    ${seat1_dict}
            &{seat2_dict}=    Create Dictionary
            ...    row=${available_seats[1]['row']}
            ...    number=${available_seats[1]['number']}
            ...    type=half
            Set Test Variable    ${SEAT_TO_BOOK_2}    ${seat2_dict}
            RETURN
        END
    END
    Fail    Could not find a session with enough available seats for testing.

Get Available Seats From Session
    [Arguments]    ${session}
    ${available_seats}=    Create List
    ${seats}=    Set Variable    ${session['seats']}
    FOR    ${seat}    IN    @{seats}
        IF    '${seat['status']}' == 'available'
            Append To List    ${available_seats}    ${seat}
        END
    END
    RETURN    ${available_seats}

*** Test Cases ***
Cenário: Criar reserva com assentos disponíveis
    [Tags]    US-RESERVE-001
    ${seats_to_reserve}=    Create List    ${SEAT_TO_BOOK_1}    ${SEAT_TO_BOOK_2}
    ${response}=    Create Reservation    ${USER_TOKEN}    ${SESSION_ID}    ${seats_to_reserve}
    Should Be Equal As Strings    ${response.status_code}    201
    ${reservation_id}=    Get Value From Json    ${response.json()}    $.data._id
    Should Not Be Empty    ${reservation_id}

Cenário: Tentar criar reserva para assento ocupado
    [Tags]    US-RESERVE-001
    ${seats_to_reserve}=    Create List    ${SEAT_TO_BOOK_1}
    Create Reservation    ${USER_TOKEN}    ${SESSION_ID}    ${seats_to_reserve}
    ${headers}=    Create Dictionary    Authorization=Bearer ${USER_TOKEN}
    ${body}=    Create Dictionary    session=${SESSION_ID}    seats=${seats_to_reserve}
    ${response}=    POST On Session
    ...    api
    ...    /reservations
    ...    json=${body}
    ...    headers=${headers}
    ...    expected_status=400
    ${message}=    Get Value From Json    ${response.json()}    $.message
    Should Contain    ${message[0]}    seats are not available

Cenário: Listar "Minhas Reservas"
    [Tags]    US-RESERVE-003
    ${seats_to_reserve}=    Create List    ${SEAT_TO_BOOK_1}
    Create Reservation    ${USER_TOKEN}    ${SESSION_ID}    ${seats_to_reserve}
    ${response}=    List My Reservations    ${USER_TOKEN}
    Should Be Equal As Strings    ${response.status_code}    200
    ${data}=    Get Value From Json    ${response.json()}    $.data
    Should Not Be Empty    ${data}

Cenário: Cancelar/Excluir uma reserva (Admin)
    [Tags]    Admin
    ${seats_to_reserve}=    Create List    ${SEAT_TO_BOOK_1}
    ${create_response}=    Create Reservation    ${USER_TOKEN}    ${SESSION_ID}    ${seats_to_reserve}
    ${reservation_id}=    Get Value From Json    ${create_response.json()}    $.data._id
    ${cancel_response}=    Cancel Reservation    ${ADMIN_TOKEN}    ${reservation_id[0]}
    Should Be Equal As Strings    ${cancel_response.status_code}    200
    ${message}=    Get Value From Json    ${cancel_response.json()}    $.message
    Should Be Equal As Strings    ${message[0]}    Reservation removed

Cenário: Validar se assentos ficam disponíveis após cancelamento
    [Tags]    Admin
    ${seats_to_reserve}=    Create List    ${SEAT_TO_BOOK_2}
    ${create_response}=    Create Reservation    ${USER_TOKEN}    ${SESSION_ID}    ${seats_to_reserve}
    ${reservation_id}=    Get Value From Json    ${create_response.json()}    $.data._id
    Cancel Reservation    ${ADMIN_TOKEN}    ${reservation_id[0]}
    ${session_response}=    Get Session By ID    ${SESSION_ID}
    ${seats_after_cancel}=    Get Value From Json    ${session_response.json()}    $.data.seats
    ${seat_status}=    Set Variable    unavailable
    FOR    ${seat}    IN    @{seats_after_cancel[0]}
        IF    "${seat['row']}" == "${SEAT_TO_BOOK_2.row}" and ${seat['number']} == ${SEAT_TO_BOOK_2.number}
            ${seat_status}=    Set Variable    ${seat['status']}
            BREAK
        END
    END
    Should Be Equal As Strings    ${seat_status}    available