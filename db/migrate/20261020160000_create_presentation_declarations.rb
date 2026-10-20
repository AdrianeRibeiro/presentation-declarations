class CreatePresentationDeclarations < ActiveRecord::Migration[8.0]
  def change
    create_table :object_declarations do |t|
      t.bigint  :platform_account_id, null: false
      t.string  :object_type, null: false
      t.jsonb   :identity, null: false, default: {}
      t.jsonb   :association_overrides, null: false, default: {}
      t.jsonb   :actions, null: false, default: []
      t.boolean :stale, null: false, default: false
      t.string  :updated_by
      t.integer :lock_version, null: false, default: 0
      t.integer :declarations_version, null: false, default: 0
      t.timestamps

      t.index %i[platform_account_id object_type], unique: true, name: 'idx_object_decl_key'
    end

    create_table :field_declarations do |t|
      t.bigint  :platform_account_id, null: false
      t.string  :object_type, null: false
      t.string  :field, null: false
      t.jsonb   :payload, null: false, default: {}
      t.boolean :stale, null: false, default: false
      t.string  :updated_by
      t.integer :lock_version, null: false, default: 0
      t.timestamps

      t.index %i[platform_account_id object_type field], unique: true, name: 'idx_field_decl_key'
    end

    create_table :surface_declarations do |t|
      t.bigint  :platform_account_id, null: false
      t.string  :object_type, null: false
      t.string  :surface, null: false
      t.string  :context_key, null: false, default: ''
      t.jsonb   :spec, null: false, default: {}
      t.boolean :stale, null: false, default: false
      t.string  :updated_by
      t.integer :lock_version, null: false, default: 0
      t.timestamps

      t.index %i[platform_account_id object_type surface context_key],
              unique: true,
              name: 'idx_surface_decl_key'
    end
  end
end
