*** Settings ***
Library    Browser

*** Keywords ***
Select Available Seats
    [Arguments]    ${count}=1
    FOR    ${i}    IN RANGE    ${count}
        Click    xpath=(//button[contains(@class, 'seat available')])[${i}+1]
    END

Click Continue To Payment
    Click    css=.checkout-button

Verify Seat Is Selected
    Get Element States    //button[contains(@class, 'seat selected')]    ==    visible