module Presentation
  module Schemas
    module Field
      SCHEMA = Schemas.compile(
        {
          type: 'object',
          properties: {
            label: Shared::NAME,
            short_label: Shared::NAME,
            semantic: Shared::SEMANTIC,
            display: {
              type: 'object',
              additionalProperties: false,
              properties: {
                widget: Shared::NULLABLE_NAME,
                icon: Shared::NULLABLE_STRING,
                format: { type: %w[object null] },
                truncate: { enum: %w[none end middle] },
                copyable: { type: 'boolean' },
                actions: Shared::STRINGS,
              },
            },
            assist: { type: 'object' },
            messages: { type: 'object' },
            options: { type: %w[object null] },
            rules: { type: 'array', items: { type: 'object' } },
            sensitivity: {
              type: 'object',
              additionalProperties: false,
              properties: {
                pii: { type: 'boolean' },
                mask_in_list: { type: 'boolean' },
              },
            },
          },
          additionalProperties: false,
        },
      )
    end
  end
end
