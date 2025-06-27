*** Settings ***
Library    Browser
Resource   ../../variables/environment_variables.robot
Resource   ./home_page.robot

*** Keywords ***
Fill Login Form
    [Arguments]    ${email}    ${password}
    Fill Text    id=email      ${email}
    Fill Text    id=password   ${password}

Submit Login Form
    Click    button[type=submit]

Verify Login Has Failed
    [Documentation]    Verifica se o login falhou, checando se a URL continua
    ...    sendo a de login e se o cabeçalho não mudou.
    Sleep    1s
    ${current_url}=    Get Url
    Should Be Equal As Strings    ${current_url}    ${BASE_URL}/login
    Wait For Elements State    nav >> text=Minhas Reservas    hidden    5s

Verify Registration Success
    Wait For Elements State    text="Conta criada com sucesso!"    visible    5s
    ${current_url}=    Get Url
    Should Be Equal As Strings    ${current_url}    ${BASE_URL}/
    Verify Logged In Header

Verify Logout
    ${current_url}=    Get Url
    Should Be Equal As Strings    ${current_url}    ${BASE_URL}/login
