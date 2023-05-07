require 'rails_helper'

describe 'User edits a order' do
  it 'and should be authenticated' do
    # Arrange
    john = User.create!(name: 'John Doe', email: 'john@email.com', password: 'password123')

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
      warehouse: warehouse, supplier: supplier, user: john, estimated_delivery_date: 10.days.from_now
    )

    # Act
    visit edit_order_path(order)

    # Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'and should be successful' do
    # Arrange
    john = User.create!(name: 'John Doe', email: 'john@email.com', password: 'password123')

    rio_warehouse = Warehouse.create!(
      name: 'Galpão Rio', description: 'Galpão do Rio de Janeiro', code: 'SDU',
      address: 'Avenida do Museu do Amanhã, 1000', city: 'Rio de Janeiro', cep: '20100-000',
      area: 60_000
    )
    maceio_warehouse = Warehouse.create!(
      name: 'Galpão Maceio', description: 'Galpão de cidade de Maceio', code: 'MCZ',
      address: 'Avenida Atlantica, 50', city: 'Maceio', cep: '80000-000',
      area: 50_000
    )

    supplier = Supplier.create!(
      corporate_name: 'Samsung Electronics LTDA', brand_name: 'Samsung', registration_number: '43447216000102',
      full_address: 'Av Paulista, 100', city: 'São Paulo', state: 'SP',
      email: 'sac@samsung.com'
    )

    order = Order.create!(
      warehouse: rio_warehouse, supplier: supplier, user: john, estimated_delivery_date: 10.days.from_now
    )

    # Act
    login_as(john)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Editar'

    select 'MCZ | Galpão Maceio', from: 'Galpão Destino'
    click_on 'Enviar'

    # Assert
    expect(current_path).to eq order_path(order)
    formatted_date = I18n.l(10.days.from_now.to_date)
    expect(page).to have_content "Data Prevista de Entrega: #{formatted_date}"
    expect(page).to have_content "Galpão Destino: MCZ | Galpão Maceio"
    expect(page).to have_content "Fornecedor: Samsung Electronics LTDA"
  end

  it 'if is its owner' do
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
    visit edit_order_path(john_order)

    # Assert
    expect(current_path).to eq root_path
  end
end
