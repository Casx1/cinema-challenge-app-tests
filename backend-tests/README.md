# Projeto de Automação de Testes para a API Cinema App

## Introdução

Este diretório contém a suíte de testes automatizados para a API RESTful do projeto **Cinema App**. O objetivo desta automação é validar de ponta a ponta a funcionalidade, segurança e regras de negócio do backend, garantindo a qualidade e estabilidade do produto.

A suíte foi desenvolvida com **Robot Framework** e implementa 100% da cobertura de cenários definida no plano de testes oficial do projeto, incluindo fluxos de autenticação, gerenciamento de entidades (Filmes, Sessões, Salas) e lógicas de reserva.

## Cobertura de Testes

A suíte de automação implementa 100% dos 37 cenários definidos no plano de testes oficial, garantindo uma cobertura abrangente dos principais fluxos da API. Os testes validam:

* **Fluxos de Usuário e Negócio:** Ciclo completo de autenticação (registro, login, perfil), fluxo de reserva de assentos (criação, validação, cancelamento) e consulta de informações públicas (filmes, sessões, salas).
* **Operações de Administrador:** Gerenciamento completo (CRUD) de todas as entidades principais: Filmes, Salas, Sessões e Usuários.
* **Segurança e Validações:** Testes de permissão para rotas exclusivas de administradores, validação de dados de entrada e tratamento de erros para requisições inválidas (ex: ID inexistente, e-mail duplicado).

## Ferramentas e Tecnologias

* **Framework:** Robot Framework
* **Linguagem:** Python 3.x
* **Bibliotecas Principais:**
    * `RequestsLibrary`: Para a execução de requisições HTTP.
    * `JSONLibrary`: Para manipulação e validação de dados em formato JSON.
    * `Collections`: Para a criação de estruturas de dados.
    * `DateTime`: Para a geração de dados dinâmicos.

## Pré-requisitos

1.  **Python 3** instalado na máquina.
2.  **PIP** (gerenciador de pacotes do Python).
3.  Uma **instância da Cinema App API** em execução localmente (ex: `http://localhost:3000`).

## Configuração do Ambiente

1.  Clone este repositório:
    ```bash
    git clone <url-do-repositorio-no-github>
    ```
2.  Navegue até o diretório do projeto:
    ```bash
    cd <nome-do-repositorio>
    ```
3.  (Recomendado) Crie e ative um ambiente virtual:
    ```bash
    # No Windows
    python -m venv venv
    .\venv\Scripts\activate

    # No macOS/Linux
    python3 -m venv venv
    source venv/bin/activate
    ```
4.  Instale as dependências do projeto:
    ```bash
    pip install -r requirements.txt
    ```
5.  Configure as variáveis de ambiente no arquivo `variables/variables.robot`, se necessário.

## Estrutura do Projeto

O projeto adota uma arquitetura modular que promove a reutilização de código e a fácil manutenção:

## Estrutura do Projeto

```text
├── keywords/         # Abstrai a lógica de negócio em keywords reutilizáveis.
├── log_results/      # Diretório padrão para os relatórios de execução.
├── resources/        # Configurações base, setup e teardown da suíte.
├── tests/            # Casos de teste escritos em Gherkin, focados no cenário.
├── variables/        # Centraliza variáveis de ambiente como URLs e credenciais.
└── requirements.txt  # Dependências Python do projeto.
```
##
## Executando os Testes

Utilize o comando `robot` no terminal, a partir do diretório raiz do projeto, para executar os testes.

* **Executar todos os testes:**
    ```bash
    robot --outputdir log_results tests/
    ```
* **Executar um arquivo de teste específico:**
    ```bash
    robot --outputdir log_results tests/test_reservations.robot
    ```
* **Executar testes por tag:**
    ```bash
    robot --outputdir log_results -i Admin tests/
    ```

## Análise dos Relatórios

A execução dos testes gera dois conjuntos de artefatos que se complementam:

#### 1. Relatórios Gerados pelo Robot Framework

Localizados no diretório `/log_results`, estes arquivos são criados automaticamente a cada execução:

* **`report.html`**: Relatório gerencial com um resumo visual, gráficos e estatísticas de PASS/FAIL.
* **`log.html`**: Log de execução técnico e detalhado, mostrando cada passo, keyword e requisição. Essencial para depuração.
* **`output.xml`**: Arquivo de saída com os dados brutos da execução, utilizado para integrações com ferramentas de CI/CD.

#### 2. Documentação de Apoio e Evidências

Localizados no diretório `/docs`, estes documentos consolidam a análise e os resultados:

* **`Relatorio_Execucao_Testes.pdf`**: O relatório técnico final que resume a cobertura dos testes, as limitações encontradas na documentação da API e as ações técnicas realizadas.
* **`Evidencias_Testes_QAlity.xlsx`**: Planilha com a matriz de rastreabilidade, listando todos os cenários do planejamento, o status final de execução e links para as evidências.

## Observações e Descobertas

Durante o desenvolvimento da automação, foram identificados os seguintes pontos técnicos relevantes:

1.  **Documentação da API:** Verificou-se que a documentação Swagger para as rotas `/sessions` e `/reservations` estava incompleta. A automação desses fluxos foi viabilizada pela análise direta do código-fonte do backend para determinar os contratos de requisição. Um ticket para a correção da documentação foi registrado.
2.  **Ambiente de Teste:** Identificou-se uma inconsistência nas credenciais do usuário administrador entre a documentação e os scripts de seed da aplicação, o que inicialmente bloqueou a execução dos testes. O problema foi isolado e um ticket para a padronização foi registrado.