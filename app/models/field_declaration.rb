class FieldDeclaration < ApplicationRecord
  include PresentationDeclaration
  include ObjectVersioned

  validates :field, presence: true, format: { with: IDENTIFIER_FORMAT }
  validates :field, uniqueness: { scope: %i[platform_account_id object_type] }
  validates :payload, json_schema: { schema: Presentation::Schemas::FIELD }
end
