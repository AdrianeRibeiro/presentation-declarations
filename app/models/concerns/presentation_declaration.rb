module PresentationDeclaration
  extend ActiveSupport::Concern

  IDENTIFIER_FORMAT = /\A[a-z][a-z0-9_]*\z/

  included do
    validates :platform_account_id, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
    validates :object_type, presence: true, format: { with: IDENTIFIER_FORMAT }

    scope :for_object, ->(account_id, object_type) { where(platform_account_id: account_id, object_type: object_type) }
    scope :active, -> { where(stale: false) }
  end

  def mark_stale!(by: nil)
    update!(stale: true, updated_by: by)
  end
end
