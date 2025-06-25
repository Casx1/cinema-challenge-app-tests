# Testes Automatizados - Cinema App

Este repositório centraliza os testes automatizados e a documentação de qualidade para a aplicação **Cinema App**, que consiste em uma API backend e uma interface frontend.

## Sumário

- [Escopo Geral do Projeto](#visão-geral-do-projeto)
- [Estrutura dos Testes](#estrutura-dos-testes)
- [Ferramentas Utilizadas](#ferramentas-utilizadas)
- [Tecnologias e Ambiente de Desenvolvimento](#tecnologias-e-ambiente-de-desenvolvimento)
- [Pré-requisitos e Instalação](#pré-requisitos-e-instalação)
- [Execução dos Testes](#execução-dos-testes)
- [Evidências de Testes e Integrações](#evidências-de-testes-e-integrações)
- [Contribuição](#contribuição)
- [Licença](#licença)

## Escopo Geral do Projeto

O objetivo deste repositório é consolidar, documentar e manter os testes para os dois principais componentes da aplicação Cinema App.

-   **API Backend (`cinema-challenge-back`)**: Uma API RESTful responsável por gerenciar toda a lógica de negócio, incluindo autenticação de usuários (comum e admin), cadastro de filmes, gerenciamento de salas, sessões e reservas de ingressos.

-   **Site Frontend (`cinema-challenge-front`)**: A interface do usuário (UI) desenvolvida em React, com a qual os clientes interagem para navegar pelos filmes em cartaz, escolher sessões, selecionar assentos e finalizar suas reservas.

Este repositório garante a cobertura de testes de ponta a ponta (E2E), validando tanto a integração entre os serviços quanto as funcionalidades isoladas de cada um.

## Estrutura dos Testes

Os testes são organizados em duas pastas principais, uma para o backend e outra para o frontend, refletindo a arquitetura da aplicação.



```text
backend-tests/
├── tests/                 # Casos de teste de alto nível (Ex: test_auth.robot)
├── keywords/              # Keywords reutilizáveis (Ex: user_keywords.robot)
├── resources/             # Arquivos base e configurações
└── variables/             # Variáveis de ambiente e dados de teste

frontend-tests/
├── tests/                 # Cenários de teste E2E (Ex: test_booking_flow.robot)
├── resources/
│   ├── page_objects/      # Page Objects para cada página da UI
│   └── common_keywords.robot  # Keywords comuns a vários testes
└── variables/             # Dados de teste e seletores de UI

logs/                      # Pasta para armazenar os logs e relatórios gerados
README.md                  # Documentação principal do repositório
```
--

-   **Formato dos Testes**:
    -   **Testes Automatizados**: A maioria dos testes é automatizada usando o Robot Framework. Os testes de API validam os endpoints, contratos e regras de negócio, enquanto os testes de frontend validam os fluxos de usuário end-to-end na interface.
    -   **Testes Manuais**: Testes exploratórios e de usabilidade são conduzidos manualmente, com casos de teste documentados e gerenciados no **QAlity for Jira**. O **Postman** é utilizado para depuração rápida e validação de novos endpoints da API.

## Ferramentas Utilizadas

A suíte de testes foi construída com um conjunto de ferramentas padrão de mercado para garantir eficiência e escalabilidade.

-   **Framework de Automação**:
    -   **Robot Framework**: Ferramenta principal para automação de testes, utilizada tanto para o backend quanto para o frontend por sua sintaxe clara e ecossistema robusto.

-   **Bibliotecas do Robot Framework**:
    -   `RequestsLibrary`: Para realizar chamadas HTTP e testar a API RESTful do backend.
    -   `JSONLibrary`: Para validar schemas e manipular dados em formato JSON nas respostas da API.
    -   `Browser Library`: Para controlar o navegador e automatizar a interação com a interface do usuário (frontend).

-   **Ferramentas Complementares**:
    -   **Postman**: Utilizado para testes manuais exploratórios da API e como ferramenta de auxílio na criação dos testes automatizados.
    -   **Jira**: Para o gerenciamento de bugs e tarefas de desenvolvimento, integrando o ciclo de vida dos defeitos aos testes.
    -   **QAlity for Jira**: Para a gestão centralizada de casos de teste, planos de execução e registro de evidências (manuais e automatizadas).
    -   **Swagger**: Utilizado como fonte de documentação oficial da API para consulta de rotas, parâmetros e modelos de dados.

## Tecnologias e Ambiente de Desenvolvimento

-   **Linguagem Principal**: Python
-   **IDE Recomendada**: VSCode com as extensões `Robot Framework Language Server` e `Python`.
-   **Ambiente**:
    -   Python 3.8+
    -   Node.js (pode ser necessário para dependências do Browser Library)
    -   Navegador compatível com o Browser Library (Chromium, Firefox, WebKit)

## Pré-requisitos e Instalação

Para configurar o ambiente local e rodar os testes, siga os passos abaixo.

1.  **Clone o repositório:**
    ```bash
    git clone <URL_DO_REPOSITORIO>
    cd cinema-challenge-app-tests
    ```

2.  **Crie e ative um ambiente virtual (recomendado):**
    ```bash
    python -m venv venv
    source venv/bin/activate  # No Windows: venv\Scripts\activate
    ```

3.  **Instale as dependências Python:**
    ```bash
    pip install -r requirements.txt
    ```

4.  **Instale os drivers dos navegadores para o Browser Library:**
    ```bash
    rfbrowser init
    ```

## Execução dos Testes

Os testes podem ser executados a partir da raiz do projeto. Os resultados, logs detalhados e relatórios serão gerados na pasta `/logs`.

-   **Executar testes do Backend:**
    ```bash
    robot -d ./logs/backend backend-tests/tests/
    ```

-   **Executar testes do Frontend:**
    ```bash
    robot -d ./logs/frontend frontend-tests/tests/
    ```

-   **Executar um arquivo de teste específico:**
    ```bash
    robot -d ./logs frontend-tests/tests/test_booking_flow.robot
    ```

-   **Executar testes em diferentes ambientes (ex: dev, staging):**
    É possível apontar para diferentes ambientes utilizando arquivos de variáveis.
    ```bash
    robot --variablefile backend-tests/variables/staging.py -d ./logs/backend backend-tests/tests/
    ```

**Interpretando os Resultados:**
Ao final da execução, dois arquivos principais são gerados na pasta de logs:
-   `report.html`: Um relatório de alto nível com o resumo e status dos testes.
-   `log.html`: Um log detalhado com cada passo executado, facilitando a depuração de falhas.

## Evidências de Testes e Integrações

A qualidade é garantida através de um processo de registro e evidência bem definido.

-   **Evidências Automatizadas**: Os arquivos `log.html` e `report.html` gerados pelo Robot Framework servem como evidência primária das execuções automatizadas. Eles contêm screenshots automáticos em caso de falha nos testes de UI.
-   **Gestão de Casos de Teste**: Todos os cenários, manuais e automatizados, são documentados como casos de teste no **QAlity for Jira**.
-   **Rastreabilidade de Bugs**: Defeitos encontrados durante as execuções são registrados no **Jira** e vinculados diretamente aos casos de teste no QAlity, permitindo total rastreabilidade desde a identificação até a correção.

## Contribuição

Contribuições são bem-vindas! Para adicionar novos testes, por favor, siga as diretrizes abaixo:

1.  **Estrutura**: Siga o padrão de organização em `tests`, `keywords` e `variables` já estabelecido. Para o frontend, utilize o padrão **Page Object Model**.
2.  **Clareza**: Escreva nomes de testes e keywords claros e objetivos, descrevendo a ação ou validação que está sendo feita.
3.  **Documentação**: Adicione documentação aos seus casos de teste e keywords usando a tag `[Documentation]` do Robot Framework.
4.  **Pull Requests**: Crie uma branch para sua nova feature ou correção (`git checkout -b feature/meu-novo-teste`) e abra um Pull Request para a branch `main` com uma descrição clara das suas alterações.

## Licença

Este projeto está sob a licença MIT. Consulte o arquivo `LICENSE` para mais detalhes.