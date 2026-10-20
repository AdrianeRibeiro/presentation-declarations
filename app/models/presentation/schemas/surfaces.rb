module Presentation
  module Schemas
    module Surfaces
      CARD = {
        type: 'object',
        additionalProperties: false,
        properties: {
          variant: { type: 'string' },
          heading: Shared::HEADING,
          heading_icon: Shared::NULLABLE_STRING,
          fields: Shared::STRINGS,
          slots: { type: 'array', items: { type: 'object' } },
          actions: Shared::STRINGS,
        },
      }.freeze

      ARRANJO = {
        type: 'object',
        required: %w[regions],
        additionalProperties: false,
        properties: {
          regions: { type: 'object' },
          cartoes: { type: 'object' },
          columns: { type: 'integer', minimum: 1 },
          adaptive: { type: 'boolean' },
        },
      }.freeze

      LISTAGEM = {
        type: 'object',
        additionalProperties: false,
        properties: {
          columns: { type: 'array', items: { type: 'object' } },
          default_sort: { type: 'object' },
          filterable_fields: Shared::STRINGS,
          searchable_fields: Shared::STRINGS,
          row_title_field: Shared::NULLABLE_NAME,
          density: { type: 'string' },
          actions: Shared::STRINGS,
        },
      }.freeze

      FORMULARIO = {
        type: 'object',
        additionalProperties: false,
        properties: {
          create: { type: 'object' },
          edit: { type: 'object' },
        },
      }.freeze

      ALL = {
        'cartao' => Schemas.compile(CARD),
        'cartao_associado' => Schemas.compile(CARD),
        'arranjo_perfil' => Schemas.compile(ARRANJO),
        'arranjo_painel' => Schemas.compile(ARRANJO),
        'listagem' => Schemas.compile(LISTAGEM),
        'formulario' => Schemas.compile(FORMULARIO),
      }.freeze
    end
  end
end
