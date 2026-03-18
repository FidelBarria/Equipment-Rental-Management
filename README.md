# Equipment Rental Management

Sistema de gerenciamento de aluguel de equipamentos para eventos, desenvolvido com Ruby on Rails 8.1.

Permite controlar o ciclo completo de locação: cadastro de equipamentos, clientes e eventos, criação de pedidos de aluguel, adição de itens, registro de pagamentos e emissão de relatórios em PDF.

---

## Funcionalidades

- **Autenticação** — Login/logout com senha criptografada (`has_secure_password`)
- **Equipamentos** — Cadastro com categorias e controle de status (disponível, alugado, indisponível, pendente)
- **Clientes** — Cadastro com CPF/CNPJ, telefone e endereço
- **Eventos** — Cadastro com datas e local, busca por nome e período
- **Aluguéis** — Criação de pedido vinculando cliente, evento e usuário; controle de status (pendente → ativo → concluído/cancelado)
- **Itens do Aluguel** — Adição de equipamentos ao pedido com cálculo automático do subtotal e total
- **Pagamentos** — Registro de pagamentos com múltiplos métodos (PIX, cartão, dinheiro, etc.)
- **Dashboard** — Visão geral com equipamentos disponíveis
- **PDF** — Impressão de detalhes do aluguel via WickedPDF

---

## Tecnologias

| Camada | Tecnologia |
|---|---|
| Backend | Ruby on Rails 8.1 |
| Banco de dados | SQLite (desenvolvimento) |
| Frontend | Bootstrap 5.3 + Bootstrap Icons |
| Autenticação | Sessão Rails + `has_secure_password` |
| PDF | WickedPDF |
| CI | GitHub Actions + Brakeman |
| Deploy | Kamal (configurado) |

---

## Como rodar localmente

### Pré-requisitos

- Ruby 3.3+
- Bundler

### Instalação

```bash
# Clone o repositório
git clone https://github.com/FidelBarria/Equipment-Rental-Management.git
cd Equipment-Rental-Management

# Instale as dependências
bundle install

# Configure o banco de dados
bin/rails db:create db:migrate db:seed

# Inicie o servidor
bin/rails server
```

Acesse `http://localhost:3000`

### Credenciais padrão (seeds)

Após rodar `db:seed`, use as credenciais definidas em `db/seeds.rb` para fazer o primeiro login.

---

## Estrutura do domínio

```
User
└── cria Rental

Client
└── participa de Rental

Event
└── vinculado a Rental (1 evento = 1 rental)

Rental
├── has_many RentalItems
├── has_many Payments
└── has_many Equipment (through: RentalItems)

Equipment
└── belongs_to Category

RentalItem
├── belongs_to Rental
└── belongs_to Equipment

Payment
└── belongs_to Rental
```

### Fluxo de status do aluguel

```
pending → active → completed
                 ↘ cancelled
```

Quando o status do aluguel muda, o status de todos os equipamentos vinculados é atualizado automaticamente:

| Status do aluguel | Status do equipamento |
|---|---|
| pending | pending |
| active | unavailable |
| completed / cancelled | available |

---

## Rodando os testes

```bash
bin/rails test
```

---

## Variáveis de ambiente

| Variável | Descrição |
|---|---|
| `RAILS_MASTER_KEY` | Chave para decriptar credenciais (necessária em produção) |
| `RAILS_LOG_LEVEL` | Nível de log (padrão: `info`) |

---

## Roadmap / melhorias planejadas

- [ ] Sistema de roles (admin vs operador)
- [ ] Paginação com Pagy ou Kaminari
- [ ] Notificações por e-mail no vencimento do aluguel
- [ ] Relatórios financeiros no dashboard
- [ ] API JSON para integração com outros sistemas

---

## Autor

**Fidel Barria**
Projeto desenvolvido para portfólio — sistema real de gestão de aluguel de equipamentos para eventos.
