require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    context 'code' do
      it 'should be random and made automatically' do
        # Arrange
        order = Order.new
  
        # Act
        order.valid?
  
        # Assert
        expect(order.code).not_to be_empty
        expect(order.code.size).to eq 10
      end
  
      it 'should be unique' do
        # Arrange
        first_order = Order.new
        second_order = Order.new
  
        # Act
        first_order.valid?
        second_order.valid?
  
        # Assert
        expect(second_order.code).not_to eq first_order.code
      end

      it 'should not be modified' do
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
        order = Order.create!(
          warehouse: warehouse, supplier: supplier, user: user, estimated_delivery_date: 10.days.from_now
        )
  
        # Act
        code_before_update = order.code
        order.update!(estimated_delivery_date: 15.days.from_now)
  
        # Assert
        expect(order.code).to eq code_before_update
      end
    end

    context 'estimated_delivery_date' do
      it 'should not be empty' do
        # Arrange
        order = Order.new(estimated_delivery_date: '')

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :estimated_delivery_date).to eq true
        expect(order.errors[:estimated_delivery_date].include? 'não pode ficar em branco').to eq true
      end

      it 'should not be in the past' do
        # Arrange
        order = Order.new(estimated_delivery_date: 1.day.ago)

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :estimated_delivery_date).to eq true
        expect(order.errors[:estimated_delivery_date].include? 'precisa ser futura').to eq true
      end

      it 'should not be today' do
        # Arrange
        order = Order.new(estimated_delivery_date: Date.today)

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :estimated_delivery_date).to eq true
        expect(order.errors[:estimated_delivery_date].include? 'precisa ser futura').to eq true
      end

      it 'should be in the future' do
        # Arrange
        order = Order.new(estimated_delivery_date: 1.day.from_now)

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :estimated_delivery_date).to eq false
      end
    end
  end
end
