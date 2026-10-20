# Increments ObjectDeclaration#declarations_version when a child changes (ETag base).
# If the object row does not exist, creates one with the column defaults.
module ObjectVersioned
  extend ActiveSupport::Concern

  included do
    after_save :bump_object_version
    after_destroy :bump_object_version
  end

  private

  def bump_object_version
    ObjectDeclaration.upsert(
      {
        platform_account_id: platform_account_id,
        object_type: object_type,
        declarations_version: 1,
        created_at: Time.current,
        updated_at: Time.current,
      },
      unique_by: :idx_object_decl_key,
      on_duplicate: Arel.sql(
        'declarations_version = object_declarations.declarations_version + 1, updated_at = CURRENT_TIMESTAMP',
      ),
    )
  end
end

