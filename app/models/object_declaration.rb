class ObjectDeclaration < ApplicationRecord
  include PresentationDeclaration

  validates :object_type, uniqueness: { scope: :platform_account_id }
  validates :identity, json_schema: { schema: Presentation::Schemas::IDENTITY }

  before_save { self.declarations_version += 1 if changed? }
end
