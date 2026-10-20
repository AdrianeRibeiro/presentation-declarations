require 'rails_helper'

RSpec.describe FieldDeclaration, type: :model do
  describe 'validations' do
    it 'accepts a payload with semantic and display' do
      declaration = described_class.new(
        platform_account_id: 1,
        object_type: 'contact',
        field: 'email',
        payload: {
          'semantic' => 'email',
          'display' => {
            'widget' => 'email',
            'icon' => 'envelope',
            'copyable' => true,
            'actions' => %w[mailto copy],
          },
        },
      )

      expect(declaration).to be_valid
    end

    it 'rejects unknown keys in the payload' do
      declaration = described_class.new(
        platform_account_id: 1,
        object_type: 'contact',
        field: 'email',
        payload: { 'unknown_block' => true },
      )

      expect(declaration).not_to be_valid
    end
  end

  describe 'object version bump' do
    it 'creates a version-carrier object_declaration when none exists' do
      described_class.create!(
        platform_account_id: 1,
        object_type: 'contact',
        field: 'email',
        payload: { 'semantic' => 'email' },
      )

      object = ObjectDeclaration.find_by!(platform_account_id: 1, object_type: 'contact')

      expect(object.declarations_version).to eq(1)
    end

    it 'increments declarations_version when a field is saved again' do
      described_class.create!(
        platform_account_id: 1,
        object_type: 'contact',
        field: 'email',
        payload: { 'semantic' => 'email' },
      )

      field = described_class.find_by!(platform_account_id: 1, object_type: 'contact', field: 'email')
      field.update!(payload: { 'semantic' => 'email', 'label' => 'E-mail' })

      object = ObjectDeclaration.find_by!(platform_account_id: 1, object_type: 'contact')

      expect(object.declarations_version).to eq(2)
    end
  end
end
