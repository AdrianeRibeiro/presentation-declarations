class SurfaceDeclaration < ApplicationRecord
  include PresentationDeclaration
  include ObjectVersioned

  SURFACES = Presentation::Schemas::SURFACES.keys.freeze
  CONTEXT_KEY_FORMAT = /\A([a-z][a-z0-9_]*:[a-z][a-z0-9_]*)?\z/

  validates :surface, inclusion: { in: SURFACES }
  validates :context_key, format: { with: CONTEXT_KEY_FORMAT }
  validates :context_key, presence: true, if: -> { surface == 'cartao_associado' }
  validates :surface, uniqueness: { scope: %i[platform_account_id object_type context_key] }
  validates :spec, json_schema: { schema: ->(record) { Presentation::Schemas::SURFACES[record.surface] } }
end
