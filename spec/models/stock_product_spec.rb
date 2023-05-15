require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  context 'serial_number' do
    it 'should be random and made automatically' do
      # Arrange
      stock_product = StockProduct.new

      # Act
      stock_product.valid?

      # Assert
      expect(stock_product.serial_number).not_to be_empty
      expect(stock_product.serial_number.size).to eq 20
    end

    it 'should be unique' do
      # Arrange
      first_stock_product = StockProduct.new
      second_stock_product = StockProduct.new

      # Act
      first_stock_product.valid?
      second_stock_product.valid?

      # Assert
      expect(second_stock_product.serial_number).not_to eq first_stock_product.serial_number
    end

    it 'should not be modified' do
      # Arrange
      user = User.create!(name: 'John Doe', email: 'john@email.com', password: 'password123')
      first_warehouse = Warehouse.create!(
        name: 'Galpão Rio', description: 'Galpão do Rio de Janeiro', code: 'SDU',
        address: 'Avenida do Museu do Amanhã, 1000', city: 'Rio de Janeiro', cep: '20100-000',
        area: 60_000
      )
      second_warehouse = Warehouse.create!(
        name: 'Galpão Maceio', description: 'Galpão de cidade de Maceio', code: 'MCZ',
        address: 'Avenida Atlantica, 50', city: 'Maceio', cep: '80000-000',
        area: 50_000
      )
      supplier = Supplier.create!(
        corporate_name: 'Samsung Electronics LTDA', brand_name: 'Samsung', registration_number: '43447216000102',
        full_address: 'Av Paulista, 100', city: 'São Paulo', state: 'SP',
        email: 'sac@samsung.com'
      )
      product = ProductModel.create!(
        name: 'Cadeira Gamer', sku: 'PA01-SAMSU-XPTO909AA',
        weight: 8_000, width: 70, height: 100, depth: 75,
        supplier: supplier
      )
      order = Order.create!(
        warehouse: first_warehouse, supplier: supplier, user: user,
        estimated_delivery_date: 10.days.from_now, status: :delivered
      )
      stock_product = StockProduct.create!(order: order, warehouse: first_warehouse, product_model: product)

      # Act
      serial_number_before_update = stock_product.serial_number
      stock_product.update!(warehouse: second_warehouse)

      # Assert
      expect(stock_product.serial_number).to eq serial_number_before_update
    end
  end

  describe '#available?' do
    it 'should return true if it has a destination' do
      # Arrange
      User.new.save!(validate: false)
      Warehouse.new.save!(validate: false)
      Supplier.new.save!(validate: false)
      ProductModel.new(
        supplier: Supplier.last
      ).save!(validate: false)
      Order.new(
        user: User.last, warehouse: Warehouse.last, supplier: Supplier.last
      ).save!(validate: false)
      stock_product = StockProduct.new(
        order: Order.last, warehouse: Warehouse.last, product_model: ProductModel.last
      )
      stock_product.save!(validate: false)
      stock_product.create_stock_product_destination(recipient: 'John Doe', address: 'Rua dos Americanos, 1000')

      # Act
      stock_product.available?

      # Assert
      expect(stock_product).to be_available
    end

    it 'should return false if it does not have a destination' do
      # Arrange
      User.new.save!(validate: false)
      Warehouse.new.save!(validate: false)
      Supplier.new.save!(validate: false)
      ProductModel.new(
        supplier: Supplier.last
      ).save!(validate: false)
      Order.new(
        user: User.last, warehouse: Warehouse.last, supplier: Supplier.last
      ).save!(validate: false)
      stock_product = StockProduct.new(
        order: Order.last, warehouse: Warehouse.last, product_model: ProductModel.last
      )
      stock_product.save!(validate: false)

      # Act
      stock_product.available?

      # Assert
      expect(stock_product).not_to be_available
    end
  end
end
