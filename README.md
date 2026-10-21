# Objects Presentation API

## Tabelas

| Tabela | Chave natural |
| --- | --- |
| `object_declarations` | `(platform_account_id, object_type)` |
| `field_declarations` | `(platform_account_id, object_type, field)` |
| `surface_declarations` | `(platform_account_id, object_type, surface, context_key)` |

`context_key` vazio (`''`) = sem contexto. `cartao_associado` exige `host:association`.

## Docker

Portas distintas da POC-1: app `3002`, Postgres `5434`.

```bash
docker compose up --build
```

Dentro da rede Compose: host `postgres`, porta `5432`.

## Testar

Com os containers no ar:

```bash
docker compose exec app bundle exec rspec
```

Para explorar no console:

```bash
docker compose exec app bin/rails c
```

Os cenários abaixo partem de um banco vazio. Rodar um `create!` de novo com a mesma chave falha com `has already been taken`.

### `object_declarations`

Sucesso: identidade do objeto `contact`.

```ruby
contact = ObjectDeclaration.create!(
  platform_account_id: 1,
  object_type: 'contact',
  updated_by: 'user_admin_conta',
  identity: {
    label_singular: 'Contato',
    label_plural: 'Contatos',
    description: 'Base de contatos da plataforma',
    icon: 'person',
    color: 'primary',
    title_field: 'nome',
    headline_field: 'cargo',
    secondary_fields: %w[email telefone instagram],
    status_field: 'ciclo_de_vida',
    avatar_field: nil
  }
)

contact.persisted?            # => true
contact.declarations_version  # => 1
```

Erro: mais de 3 destaques em `secondary_fields`.

```ruby
invalid = ObjectDeclaration.new(
  platform_account_id: 2,
  object_type: 'contact',
  identity: { label_singular: 'Contato', secondary_fields: %w[email telefone instagram cargo] }
)

invalid.valid?            # => false
invalid.errors[:identity] # => ["/secondary_fields: array size at `/secondary_fields` is greater than: 3"]
```

### `field_declarations`

Sucesso: campo `email` de `contact`.

```ruby
email = FieldDeclaration.create!(
  platform_account_id: 1,
  object_type: 'contact',
  field: 'email',
  updated_by: 'user_admin_conta',
  payload: {
    semantic: 'email',
    display: {
      widget: 'email', icon: 'envelope', format: nil, truncate: 'middle',
      copyable: true, actions: %w[mailto copy]
    },
    assist: {
      placeholder: 'nome@empresa.com.br',
      helper_text: { i18n_key: 'field.email.helper', text: 'Usado para identificar o contato em integrações.' },
      example: 'marcos.vieira@acme.com.br',
      mask: nil,
      meter: nil
    },
    messages: {
      required: { i18n_key: 'validation.required', text: 'Informe o e-mail.' },
      string_format: { i18n_key: 'validation.email', text: 'E-mail inválido. Verifique se há @ e domínio.' },
      max_len: { i18n_key: 'validation.max_len', text: 'Máximo de {limit} caracteres.' }
    },
    options: nil,
    rules: [],
    sensitivity: { pii: true, mask_in_list: false }
  }
)

email.persisted? # => true
ObjectDeclaration.find_by(platform_account_id: 1, object_type: 'contact').declarations_version
# => 2 (salvar um campo incrementa a versão do objeto)
```

Erro: `structural` no payload. Esse bloco é espelho da Objects API e não é persistido aqui.

```ruby
invalid = FieldDeclaration.new(
  platform_account_id: 1,
  object_type: 'contact',
  field: 'telefone',
  payload: { semantic: 'phone', structural: { type: 'string', required: false } }
)

invalid.valid?           # => false
invalid.errors[:payload] # => ["/structural: object property at `/structural` is a disallowed additional property"]
```

### `surface_declarations`

Sucesso: superfície `cartao_associado` de `contact` e de `negociacao`.

```ruby
cartao = SurfaceDeclaration.create!(
  platform_account_id: 1,
  object_type: 'contact',
  surface: 'cartao_associado',
  context_key: 'contact:contatos',
  updated_by: 'user_admin_conta',
  spec: {
    variant: 'object',
    fields: %w[email telefone instagram],
    slots: [{ id: 'resumo', widget: 'field-list', props: { fields: '{{fields}}' } }]
  }
)

cartao = SurfaceDeclaration.create!(
  platform_account_id: 1,
  object_type: 'negociacao',
  surface: 'cartao_associado',
  context_key: 'contact:negociacoes',
  updated_by: 'user_admin_conta',
  spec: {
    variant: 'object',
    fields: %w[titulo valor etapa],
    slots: []
  }
)

cartao.persisted? # => true
```

Erro: `cartao_associado` sem contexto.

```ruby
invalid = SurfaceDeclaration.new(
  platform_account_id: 1,
  object_type: 'negociacao',
  surface: 'cartao_associado',
  spec: { variant: 'object', fields: %w[titulo valor etapa] }
)

invalid.valid?                       # => false
invalid.errors.details[:context_key] # => [{ error: :blank }]
```
