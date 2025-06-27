*** Settings ***
Library    Browser

*** Keywords ***
Go To My Reservations
    Click    text="Minhas Reservas"

Verify Reservation Is Displayed
    Wait For Elements State    css=.reservation-card    visible    10s
    Get Element States    css=.reservation-card    ==    visible