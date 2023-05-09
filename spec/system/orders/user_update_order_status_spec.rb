require 'rails_helper'

describe 'User informs new order status' do
  it 'and order was delivered' do
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
      warehouse: warehouse, supplier: supplier, user: john,
      estimated_delivery_date: 10.days.from_now, status: :pending
    )

    # Act
    login_as(john)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como Entregue'

    # Assert
    expect(current_path).to eq order_path(order)
    expect(page).to have_content 'Pedido marcado como entregue.'
    expect(page).to have_content 'Situação do Pedido: Entregue'
    expect(page).not_to have_content 'Cancelar Pedido'
  end

  it 'and order was canceled' do
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
      warehouse: warehouse, supplier: supplier, user: john,
      estimated_delivery_date: 10.days.from_now, status: :pending
    )

    # Act
    login_as(john)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Cancelar Pedido'

    # Assert
    expect(current_path).to eq order_path(order)
    expect(page).to have_content 'Pedido cancelado com sucesso.'
    expect(page).to have_content 'Situação do Pedido: Cancelado'
    expect(page).not_to have_content 'Marcar como Entregue'
  end
end
