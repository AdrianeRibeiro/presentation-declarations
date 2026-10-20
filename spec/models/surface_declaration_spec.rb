require 'rails_helper'

RSpec.describe SurfaceDeclaration, type: :model do
  describe 'validations' do
    it 'accepts cartao with empty context_key' do
      declaration = described_class.new(
        platform_account_id: 1,
        object_type: 'contact',
        surface: 'cartao',
        context_key: '',
        spec: { 'fields' => %w[nome email] },
      )

      expect(declaration).to be_valid
    end

    it 'rejects cartao_associado without context_key' do
      declaration = described_class.new(
        platform_account_id: 1,
        object_type: 'negociacao',
        surface: 'cartao_associado',
        context_key: '',
        spec: { 'fields' => %w[titulo] },
      )

      expect(declaration).not_to be_valid
    end

    it 'accepts cartao_associado with host:association context_key' do
      declaration = described_class.new(
        platform_account_id: 1,
        object_type: 'negociacao',
        surface: 'cartao_associado',
        context_key: 'contact:negociacoes',
        spec: { 'fields' => %w[titulo valor] },
      )

      expect(declaration).to be_valid
    end

    it 'rejects an unknown surface' do
      declaration = described_class.new(
        platform_account_id: 1,
        object_type: 'contact',
        surface: 'timeline',
        context_key: '',
        spec: {},
      )

      expect(declaration).not_to be_valid
    end
  end

  describe 'surface vocabulary parity' do
    it 'matches the database check vocabulary' do
      expect(described_class::SURFACES).to match_array(
        %w[cartao cartao_associado arranjo_perfil arranjo_painel listagem formulario],
      )
    end
  end
end
