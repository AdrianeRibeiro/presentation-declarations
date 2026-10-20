require 'rails_helper'

RSpec.describe ObjectDeclaration, type: :model do
  describe 'validations' do
    it 'accepts a declared identity with up to 3 secondary_fields' do
      declaration = described_class.new(
        platform_account_id: 1,
        object_type: 'contact',
        identity: {
          'label_singular' => 'Contato',
          'label_plural' => 'Contatos',
          'title_field' => 'nome',
          'secondary_fields' => %w[email telefone cargo],
        },
      )

      expect(declaration).to be_valid
    end

    it 'rejects secondary_fields with more than 3 items' do
      declaration = described_class.new(
        platform_account_id: 1,
        object_type: 'contact',
        identity: {
          'secondary_fields' => %w[email telefone cargo empresa],
        },
      )

      expect(declaration).not_to be_valid
    end

    it 'rejects invalid object_type format' do
      declaration = described_class.new(
        platform_account_id: 1,
        object_type: 'Contact',
        identity: {},
      )

      expect(declaration).not_to be_valid
    end
  end

  describe 'declarations_version' do
    it 'increments on each save of the object declaration' do
      declaration = described_class.create!(
        platform_account_id: 1,
        object_type: 'contact',
        identity: { 'label_singular' => 'Contato' },
      )

      expect(declaration.declarations_version).to eq(1)

      declaration.update!(identity: { 'label_singular' => 'Contato', 'label_plural' => 'Contatos' })

      expect(declaration.reload.declarations_version).to eq(2)
    end
  end
end
