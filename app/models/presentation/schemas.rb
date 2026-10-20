require 'json_schemer'

module Presentation
  module Schemas
    def self.compile(definition)
      JSONSchemer.schema(definition.as_json)
    end

    IDENTITY = ObjectDeclaration::IDENTITY
    FIELD = Field::SCHEMA
    SURFACES = Surfaces::ALL
  end
end
