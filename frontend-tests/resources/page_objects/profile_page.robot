*** Settings ***
Library    Browser

*** Keywords ***
Update User Name
    [Arguments]    ${new_name}
    Fill Text    id=name    ${new_name}
    Click    button[type=submit]

Verify Name Update
    [Arguments]    ${new_name}
    Wait For Elements State    text="Perfil atualizado com sucesso"    visible    5s
    Get Text    id=name    ==    ${new_name}

Go To Profile
    Click    text=Perfil

Logout
    Click    css=.btn-logout