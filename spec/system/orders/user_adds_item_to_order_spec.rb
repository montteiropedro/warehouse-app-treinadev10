require 'rails_helper'

describe 'User adds item to order' do
  it 'should be successful' do
    # Arrange
    user = User.create!(name: 'John Doe', email: 'john@email.com', password: 'password123')
    supplier = Supplier.create!(
      corporate_name: 'Samsung Electronics LTDA', brand_name: 'Samsung', registration_number: '43447216000102',
      full_address: 'Av Paulista, 100', city: 'São Paulo', state: 'SP',
      email: 'sac@samsung.com'
    )
    product_a = ProductModel.create!(
      name: 'Produto A', sku: 'PA01-SAMSU-XPTO909AA',
      weight: 8_000, width: 70, height: 45, depth: 10,
      supplier: supplier
    )
    product_b = ProductModel.create!(
      name: 'Produto B', sku: 'PB02-SAMSU-XPTO909BB',
      weight: 8_000, width: 70, height: 45, depth: 10,
      supplier: supplier
    )
    warehouse = Warehouse.create!(
      name: 'Galpão Rio', description: 'Galpão do Rio de Janeiro', code: 'SDU',
      address: 'Avenida do Museu do Amanhã, 1000', city: 'Rio de Janeiro', cep: '20100-000',
      area: 60_000
    )
    order = Order.create!(
      warehouse: warehouse, supplier: supplier, user: user,
      estimated_delivery_date: 10.days.from_now, status: :pending
    )

    # Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'
    select 'Produto A', from: 'Produto'
    fill_in 'Quantidade', with: 8
    click_on 'Adicionar'

    # Assert
    expect(current_path).to eq order_path(order)
    expect(page).to have_content 'Item adicionado com sucesso.'
    expect(page).to have_content '8 x Produto A'
  end

  it 'should not see other suppliers product models' do
    # Arrange
    user = User.create!(name: 'John Doe', email: 'john@email.com', password: 'password123')
    supplier_a = Supplier.create!(
      corporate_name: 'Samsung Electronics LTDA', brand_name: 'Samsung', registration_number: '43447216000102',
      full_address: 'Av Paulista, 100', city: 'São Paulo', state: 'SP',
      email: 'sac@samsung.com'
    )
    supplier_b = Supplier.create!(
      corporate_name: 'LG Electronics LTDA', brand_name: 'LG', registration_number: '16074559000104',
      full_address: 'Av das Américas, 1000', city: 'Rio de Janeiro', state: 'RJ',
      email: 'contato@lg.com'
    )
    product_a = ProductModel.create!(
      name: 'Produto A', sku: 'PA01-SAMSU-XPTO909AA',
      weight: 8_000, width: 70, height: 45, depth: 10,
      supplier: supplier_a
    )
    product_b = ProductModel.create!(
      name: 'Produto B', sku: 'PB02-SAMSU-XPTO909BB',
      weight: 8_000, width: 70, height: 45, depth: 10,
      supplier: supplier_b
    )
    warehouse = Warehouse.create!(
      name: 'Galpão Rio', description: 'Galpão do Rio de Janeiro', code: 'SDU',
      address: 'Avenida do Museu do Amanhã, 1000', city: 'Rio de Janeiro', cep: '20100-000',
      area: 60_000
    )
    order = Order.create!(
      warehouse: warehouse, supplier: supplier_a, user: user,
      estimated_delivery_date: 10.days.from_now, status: :pending
    )
    # Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'

    # Assert
    expect(page).to have_content 'Produto A'
    expect(page).not_to have_content 'Produto B'
  end
end
