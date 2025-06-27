*** Settings ***
Library    Browser
Resource   ../../variables/environment_variables.robot

*** Keywords ***
Navigate To Home
    Go To    ${BASE_URL}

Select First Movie
    Click    css=.movie-grid .movie-card:first-child .btn

Verify Logged In Header
    Wait For Elements State    text="Minhas Reservas"    visible    5s
    Wait For Elements State    text="Perfil"            visible    5s
    Wait For Elements State    text="Sair"              visible    5s

Verify Logged Out Header
    Wait For Elements State    nav >> text=Login       visible    5s
    Wait For Elements State    nav >> text=Cadastrar   visible    5s