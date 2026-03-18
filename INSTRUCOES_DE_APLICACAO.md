# Como aplicar as correções

Copie cada arquivo para o local correspondente no seu projeto:

## Controllers
```
fixes/app/controllers/application_controller.rb  →  app/controllers/application_controller.rb
fixes/app/controllers/sessions_controller.rb     →  app/controllers/sessions_controller.rb
fixes/app/controllers/rentals_controller.rb      →  app/controllers/rentals_controller.rb
fixes/app/controllers/rental_items_controller.rb →  app/controllers/rental_items_controller.rb
fixes/app/controllers/payments_controller.rb     →  app/controllers/payments_controller.rb
```

## Models
```
fixes/app/models/rental.rb       →  app/models/rental.rb
fixes/app/models/rental_item.rb  →  app/models/rental_item.rb
fixes/app/models/equipment.rb    →  app/models/equipment.rb
```

## Testes
```
fixes/test/models/rental_test.rb       →  test/models/rental_test.rb
fixes/test/models/rental_item_test.rb  →  test/models/rental_item_test.rb
fixes/test/models/equipment_test.rb    →  test/models/equipment_test.rb
```

## README
```
fixes/README.md  →  README.md
```

---

## O que cada arquivo corrige

### application_controller.rb
- Indentação corrigida e consistente
- Lógica de `current_user` simplificada (early return)
- `require_user` simplificado com `return if logged_in?`

### sessions_controller.rb
- Removido `puts "entrou no destroy"` (debug em produção)
- Logout agora redireciona para `login_path` (correto)

### rentals_controller.rb
- Corrigido bug crítico: `render "/login"` → `render :new` quando save falha
- Adicionado `show_details_print` action
- Scopes encadeáveis no index
- PDF aponta para template correta

### rental_items_controller.rb
- Removido `puts` de debug
- Index lista apenas items do rental atual (não todos)
- New mostra apenas equipamentos disponíveis por padrão

### payments_controller.rb
- Removido `puts params.inspect` (debug em produção)
- Index lista pagamentos do rental, não todos

### rental.rb
- `update_all` em vez de `update` (evita callbacks desnecessários)
- Guard `return unless saved_change_to_status?` evita loops
- `dependent: :destroy` em rental_items e payments
- Scope `by_start_date` renomeado (era conflitante com coluna)

### rental_item.rb
- Consistente com regra STATUS-only (sem lógica de quantity em estoque)
- `before_save :calculate_subtotal` calcula automático baseado em dias
- Mensagem de erro mais clara com nome do equipamento

### equipment.rb
- Scope `available_for_rental` adicionado (usado pelo RentalItemsController)
- Validações de nome e daily_value adicionadas

### Testes
- 25+ testes cobrindo as regras de negócio principais
- Testar: validações, status transitions, cálculo de total, disponibilidade de equipamento
