*** Settings ***
Library    RequestsLibrary

*** Keywords ***
Register User Via API
    [Documentation]    Cadastra um novo usuário diretamente via API para preparar
    ...              o ambiente de teste de forma rápida e confiável.
    [Arguments]    ${user_data}

    Create Session    api_session    http://localhost:3000
    &{headers}=      Create Dictionary    Content-Type=application/json

    ${response}=     Post On Session
    ...              api_session
    ...              /api/v1/auth/register
    ...              json=${user_data}
    ...              headers=${headers}

    Should Be Equal As Strings    ${response.status_code}    201