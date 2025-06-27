# Projeto de Automação de Testes - Cinema App Frontend

## 1. Introdução

Este repositório contém a suíte completa de testes automatizados End-to-End (E2E) para a aplicação **Cinema App Frontend**. O objetivo deste projeto é garantir a qualidade, funcionalidade e estabilidade da interface do usuário, validando todos os fluxos críticos da aplicação, desde o registro de usuários até a reserva de ingressos.

A automação foi desenvolvida utilizando o **Robot Framework**, com uma abordagem moderna que combina testes de UI com interações de API para preparação de ambiente, garantindo testes robustos, rápidos e confiáveis.

## 2. Tecnologias Utilizadas

* **Framework de Automação:** Robot Framework
* **Linguagem de Scripting:** Python 3
* **Biblioteca de Interação Web:** Browser (baseada em Playwright)
* **Biblioteca de Requisições API:** RequestsLibrary
* **Bibliotecas de Apoio:** JSONLibrary, Collections, String

## 3. Estrutura do Projeto

O projeto está organizado de forma a promover a reutilização de código e a fácil manutenção, seguindo o padrão Page Objects:

```
/cinema-frontend-tests
|
|--- tests/
|   |--- test_authentication.robot
|   |--- test_booking_flow.robot
|   |--- test_profile_and_reservations.robot
|
|--- resources/
|   |--- common_keywords.robot
|   |--- api_keywords.robot
|   |--- page_objects/
|
|--- variables/
|   |--- environment_variables.robot
|   |--- test_data.py
|
|--- requirements.txt
```

* **`tests/`**: Contém os arquivos de teste de alto nível, escritos em Gherkin, que descrevem os cenários de negócio.
* **`resources/`**: Agrupa as keywords reutilizáveis.
  * **`page_objects/`**: Abstrai as interações com cada página da aplicação.
  * **`api_keywords.robot`**: Centraliza as keywords que interagem diretamente com a API para setup de testes.
* **`variables/`**: Armazena dados de teste, como URLs de ambiente e funções para geração de dados dinâmicos.

## 4. Configuração do Ambiente

Siga os passos abaixo para configurar o ambiente de execução dos testes.

### Pré-requisitos

* Python 3.8 ou superior
* pip (gerenciador de pacotes do Python)

### Instalação

1.  **Clone o repositório:**
    ```bash
    git clone <url-do-repositorio>
    cd cinema-frontend-tests
    ```

2.  **Instale as dependências:**
    ```bash
    pip install -r requirements.txt
    ```

3.  **Inicialize a Browser Library:**
    Este comando fará o download dos navegadores necessários para o Playwright.
    ```bash
    rfbrowser init
    ```

## 5. Execução dos Testes

Para executar a suíte de testes completa, utilize o comando abaixo na raiz do projeto:

```bash
robot -d results .
```

* `robot`: Executa o Robot Framework.
* `-d results`: Especifica que os relatórios de saída devem ser salvos na pasta `results`.
* `.`: Indica que o Robot deve procurar por arquivos de teste no diretório atual e em seus subdiretórios.

### Visualizando os Relatórios

Após a execução, os seguintes arquivos serão gerados dentro da pasta `results/`:

* **`report.html`**: Um relatório de alto nível com gráficos e estatísticas da execução.
* **`log.html`**: Um log detalhado com o passo a passo de cada teste, ideal para depuração.

## 6. Licença

Este projeto está licenciado sob a Licença MIT. Consulte o arquivo `LICENSE` para mais detalhes.