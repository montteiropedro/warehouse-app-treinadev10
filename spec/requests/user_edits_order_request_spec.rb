require 'rails_helper'

describe 'User edits a order' do
  it 'and is not its owner' do
    # Arrange
    john = User.create!(name: 'John Doe', email: 'john@email.com', password: 'password123')
    steve = User.create!(name: 'Steve Doe', email: 'steve@email.com', password: 'password123')

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

    john_order = Order.create!(
      warehouse: warehouse, supplier: supplier, user: john, estimated_delivery_date: 10.days.from_now
    )

    # Act
    login_as(steve)
    patch order_path(john_order), params: { order: { supplier_id: 2 } }

    # Assert
    expect(response).to redirect_to root_path
  end
end
