module Presentation
  module Schemas
    module ObjectDeclaration
      IDENTITY = Schemas.compile(
        {
          type: 'object',
          properties: {
            label_singular: Shared::NAME,
            label_plural: Shared::NAME,
            description: Shared::NULLABLE_STRING,
            icon: Shared::NULLABLE_STRING,
            color: Shared::NULLABLE_STRING,
            title_field: Shared::NULLABLE_NAME,
            headline_field: Shared::NULLABLE_NAME,
            status_field: Shared::NULLABLE_NAME,
            avatar_field: Shared::NULLABLE_NAME,
            secondary_fields: { type: 'array', maxItems: 3, uniqueItems: true, items: Shared::NAME },
          },
          additionalProperties: false,
        },
      )
    end
  end
end
