require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'should return false when corporate_name is empty' do
        # Arrange
        supplier = Supplier.new(
          corporate_name: '', brand_name: 'ACME', registration_number: '43447216000102',
          full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP',
          email: 'contato@acme.com'
        )

        # Act
        result = supplier.valid?

        # Assert
        expect(result).to be false
      end

      it 'should return false when brand_name is empty' do
        # Arrange
        supplier = Supplier.new(
          corporate_name: 'ACME LTDA', brand_name: '', registration_number: '43447216000102',
          full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP',
          email: 'contato@acme.com'
        )

        # Act
        result = supplier.valid?

        # Assert
        expect(result).to be false
      end

      it 'should return false when registration_number is empty' do
        # Arrange
        supplier = Supplier.new(
          corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '',
          full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP',
          email: 'contato@acme.com'
        )

        # Act
        result = supplier.valid?

        # Assert
        expect(result).to be false
      end

      it 'should return false when full_address is empty' do
        # Arrange
        supplier = Supplier.new(
          corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
          full_address: '', city: 'Bauru', state: 'SP',
          email: 'contato@acme.com'
        )

        # Act
        result = supplier.valid?

        # Assert
        expect(result).to be false
      end

      it 'should return false when city is empty' do
        # Arrange
        supplier = Supplier.new(
          corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
          full_address: 'Av das Palmas, 100', city: '', state: 'SP',
          email: 'contato@acme.com'
        )

        # Act
        result = supplier.valid?

        # Assert
        expect(result).to be false
      end

      it 'should return false when state is empty' do
        # Arrange
        supplier = Supplier.new(
          corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
          full_address: 'Av das Palmas, 100', city: 'Bauru', state: '',
          email: 'contato@acme.com'
        )

        # Act
        result = supplier.valid?

        # Assert
        expect(result).to be false
      end

      it 'should return false when email is empty' do
        # Arrange
        supplier = Supplier.new(
          corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
          full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP',
          email: ''
        )

        # Act
        result = supplier.valid?

        # Assert
        expect(result).to be false
      end
    end

    context 'uniqueness' do
      it 'should return false when registration_number is alredy in use' do
        # Arrange
        first_supplier = Supplier.create!(
          corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
          full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP',
          email: 'contato@acme.com'
        )

        second_supplier = Supplier.new(
          corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '43447216000102',
          full_address: 'Torre da Indústria, 1000', city: 'Teresina', state: 'PI',
          email: 'vendas@spark.com.br'
        )

        # Act
        result = second_supplier.valid?

        # Assert
        expect(result).to be false
      end
    end

    context 'length' do
      it 'should return false when registration_number length is not 14' do
        # Arrange
        supplier = Supplier.new(
          corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '434472',
          full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP',
          email: 'contato@acme.com'
        )

        # Act
        result = supplier.valid?

        # Assert
        expect(result).to be false
      end
    end
  end
end
