require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'should return false when name is empty' do
        # Arrange
        warehouse = Warehouse.new(
          name: '', description: 'Galpão do Rio de Janeiro', code: 'SDU',
          address: 'Avenida do Museu do Amanhã, 1000', city: 'Rio de Janeiro', cep: '20100-000',
          area: 60_000
        )
        # Act
        result = warehouse.valid?
  
        # Assert
        expect(result).to be false
      end
  
      it 'should return false when description is empty' do
        # Arrange
        warehouse = Warehouse.new(
          name: 'Rio', description: '', code: 'SDU',
          address: 'Avenida do Museu do Amanhã, 1000', city: 'Rio de Janeiro', cep: '20100-000',
          area: 60_000
        )
        # Act
        result = warehouse.valid?
  
        # Assert
        expect(result).to be false
      end

      it 'should return false when code is empty' do
        # Arrange
        warehouse = Warehouse.new(
          name: 'Rio', description: 'Galpão do Rio de Janeiro', code: '',
          address: 'Avenida do Museu do Amanhã, 1000', city: 'Rio de Janeiro', cep: '20100-000',
          area: 60_000
        )
        # Act
        result = warehouse.valid?
  
        # Assert
        expect(result).to be false
      end

      it 'should return false when address is empty' do
        # Arrange
        warehouse = Warehouse.new(
          name: 'Rio', description: 'Galpão do Rio de Janeiro', code: 'SDU',
          address: '', city: 'Rio de Janeiro', cep: '20100-000',
          area: 60_000
        )
        # Act
        result = warehouse.valid?
  
        # Assert
        expect(result).to be false
      end
  
      it 'should return false when city is empty' do
        # Arrange
        warehouse = Warehouse.new(
          name: 'Rio', description: 'Galpão do Rio de Janeiro', code: 'SDU',
          address: 'Avenida do Museu do Amanhã, 1000', city: '', cep: '20100-000',
          area: 60_000
        )
        # Act
        result = warehouse.valid?
  
        # Assert
        expect(result).to be false
      end
  
      it 'should return false when cep is empty' do
        # Arrange
        warehouse = Warehouse.new(
          name: 'Rio', description: 'Galpão do Rio de Janeiro', code: 'SDU',
          address: 'Avenida do Museu do Amanhã, 1000', city: 'Rio de Janeiro', cep: '',
          area: 60_000
        )
        # Act
        result = warehouse.valid?
  
        # Assert
        expect(result).to be false
      end
  
      it 'should return false when area is empty' do
        # Arrange
        warehouse = Warehouse.new(
          name: 'Rio', description: 'Galpão do Rio de Janeiro', code: 'SDU',
          address: 'Avenida do Museu do Amanhã, 1000', city: 'Rio de Janeiro', cep: '20100-000',
          area: ''
        )
        # Act
        result = warehouse.valid?
  
        # Assert
        expect(result).to be false
      end
    end

    context 'uniqueness' do
      it 'should return false when code is already in use' do
        # Arrange
        first_warehouse = Warehouse.create(
          name: 'Rio', description: 'Galpão do Rio de Janeiro', code: 'RIO',
          address: 'Avenida do Museu do Amanhã, 1000', city: 'Rio de Janeiro', cep: '20100-000',
          area: 60_000
        )

        second_warehouse = Warehouse.new(
          name: 'Niteroi', description: 'Galpão de Niteroi', code: 'RIO',
          address: 'Avenida de Niteroi, 50', city: 'Niteroi', cep: '30100-000',
          area: 35_000
        )
        # Act
        result = second_warehouse.valid?
  
        # Assert
        expect(result).to be false
      end
    end

    context 'length' do
      it 'should return false when code length is not 3' do
        # Arrange
        warehouse = Warehouse.new(
          name: 'Rio', description: 'Galpão do Rio de Janeiro', code: 'SD',
          address: 'Avenida do Museu do Amanhã, 1000', city: 'Rio de Janeiro', cep: '20100-000',
          area: 60_000
        )
        # Act
        result = warehouse.valid?
  
        # Assert
        expect(result).to be false
      end
    end
  end
end
