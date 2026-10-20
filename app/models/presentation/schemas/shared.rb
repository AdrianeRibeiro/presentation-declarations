module Presentation
  module Schemas
    module Shared
      NAME = { type: 'string', minLength: 1 }.freeze
      NULLABLE_NAME = { type: %w[string null], minLength: 1 }.freeze
      NULLABLE_STRING = { type: %w[string null] }.freeze
      SEMANTIC = { type: %w[string null], pattern: '^[a-z][a-z0-9_]*$' }.freeze
      STRINGS = { type: 'array', uniqueItems: true, items: NAME }.freeze
      HEADING = { type: %w[string object] }.freeze
    end
  end
end
