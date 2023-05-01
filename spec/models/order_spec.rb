require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'code' do
    it 'should be random and made automatically' do
      # Arrange
      user = User.create!(name: 'John Doe', email: 'john@email.com', password: 'password123')

      warehouse = Warehouse.create!(
        name: 'Galpão Rio', description: 'Galpão do Rio de Janeiro', code: 'SDU',
        address: 'Avenida do Museu do Amanhã, 1000', city: 'Rio de Janeiro', cep: '20100-000',
        area: 60_000
      )

      supplier = Supplier.create!(
        corporate_name: 'Samsung Electronics LTDA', brand_name: 'Samsung', registration_number: '43447216000102',
        full_address: 'Av Paulista, 100', city: 'São Paulo', state: 'SP',
        email: 'sac@samsung.com'
      )

      order = Order.new(
        user: user, warehouse: warehouse, supplier: supplier,
        estimated_delivery_date: '2023-12-20'
      )

      # Act
      order.save!
      result = order.code

      # Assert
      expect(result).not_to be_empty
      expect(result.size).to eq 10
    end

    it 'should be unique' do
      # Arrange
      user = User.create!(name: 'John Doe', email: 'john@email.com', password: 'password123')

      warehouse = Warehouse.create!(
        name: 'Galpão Rio', description: 'Galpão do Rio de Janeiro', code: 'SDU',
        address: 'Avenida do Museu do Amanhã, 1000', city: 'Rio de Janeiro', cep: '20100-000',
        area: 60_000
      )

      supplier = Supplier.create!(
        corporate_name: 'Samsung Electronics LTDA', brand_name: 'Samsung', registration_number: '43447216000102',
        full_address: 'Av Paulista, 100', city: 'São Paulo', state: 'SP',
        email: 'sac@samsung.com'
      )

      first_order = Order.create!(
        user: user, warehouse: warehouse, supplier: supplier,
        estimated_delivery_date: '2023-12-20'
      )
      second_order = Order.new(
        user: user, warehouse: warehouse, supplier: supplier,
        estimated_delivery_date: '2023-12-23'
      )

      # Act
      second_order.save!

      # Assert
      expect(second_order.code).not_to eq first_order.code
    end

    it 'should not be null' do
      # Arrange
      user = User.create!(name: 'John Doe', email: 'john@email.com', password: 'password123')

      warehouse = Warehouse.create!(
        name: 'Galpão Rio', description: 'Galpão do Rio de Janeiro', code: 'SDU',
        address: 'Avenida do Museu do Amanhã, 1000', city: 'Rio de Janeiro', cep: '20100-000',
        area: 60_000
      )

      supplier = Supplier.create!(
        corporate_name: 'Samsung Electronics LTDA', brand_name: 'Samsung', registration_number: '43447216000102',
        full_address: 'Av Paulista, 100', city: 'São Paulo', state: 'SP',
        email: 'sac@samsung.com'
      )

      order = Order.new(
        user: user, warehouse: warehouse, supplier: supplier,
        estimated_delivery_date: '2023-12-20'
      )

      # Act
      result = order.valid?

      # Assert
      expect(result).to be true
    end
  end

  describe '#valid?' do
    context 'presence' do
      it 'should return false when estimated_delivery_date is empty' do
        # Arrange
        user = User.create!(name: 'John Doe', email: 'john@email.com', password: 'password123')

        warehouse = Warehouse.create!(
          name: 'Galpão Rio', description: 'Galpão do Rio de Janeiro', code: 'SDU',
          address: 'Avenida do Museu do Amanhã, 1000', city: 'Rio de Janeiro', cep: '20100-000',
          area: 60_000
        )

        supplier = Supplier.create!(
          corporate_name: 'Samsung Electronics LTDA', brand_name: 'Samsung', registration_number: '43447216000102',
          full_address: 'Av Paulista, 100', city: 'São Paulo', state: 'SP',
          email: 'sac@samsung.com'
        )

        order = Order.new(
          user: user, warehouse: warehouse, supplier: supplier,
          estimated_delivery_date: ''
        )

        # Act
        result = order.valid?

        # Assert
        expect(result).to eq false
      end
    end

    context 'comparison' do
      it 'should return false when estimated_delivery_date is not a future date' do
        # Arrange
        user = User.create!(name: 'John Doe', email: 'john@email.com', password: 'password123')

        warehouse = Warehouse.create!(
          name: 'Galpão Rio', description: 'Galpão do Rio de Janeiro', code: 'SDU',
          address: 'Avenida do Museu do Amanhã, 1000', city: 'Rio de Janeiro', cep: '20100-000',
          area: 60_000
        )

        supplier = Supplier.create!(
          corporate_name: 'Samsung Electronics LTDA', brand_name: 'Samsung', registration_number: '43447216000102',
          full_address: 'Av Paulista, 100', city: 'São Paulo', state: 'SP',
          email: 'sac@samsung.com'
        )

        date = Date.today
        
        order = Order.new(
          user: user, warehouse: warehouse, supplier: supplier,
          estimated_delivery_date: date
        )

        # Act
        result = order.valid?

        # Assert
        expect(result).to eq false
      end
    end
  end
end
