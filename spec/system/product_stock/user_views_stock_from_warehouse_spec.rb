require 'rails_helper'

describe 'User sees the stock' do
  it 'from warehouse page' do
    # Arrange
    user = User.create!(name: 'John Doe', email: 'john@email.com', password: 'password123')

    warehouse = Warehouse.create(
      name: 'Aeroporto SP', description: 'Galpão destinado para cargas internacionais', code: 'SDU',
      address: 'Avenida do Aeroporto, 1000', city: 'Guarulhos', cep: '15000-000',
      area: 100_000
    )

    supplier = Supplier.create!(
      corporate_name: 'Samsung Electronics LTDA', brand_name: 'Samsung', registration_number: '83887616033136',
      full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP',
      email: 'sac@samsung.com'
    )

    order = Order.create!(
      warehouse: warehouse, supplier: supplier, user: user,
      estimated_delivery_date: 1.days.from_now
    )

    product_tv = ProductModel.create!(
      name: 'TV 32', sku: 'TV32-SAMSU-XPTO909BB',
      weight: 8_000, width: 70, height: 45, depth: 10,
      supplier: supplier
    )

    product_soundbar = ProductModel.create!(
      name: 'SoundBar 7.1 Surround', sku: 'SB71-SAMSU-NOIZ501SA',
      weight: 3_000, width: 80, height: 15, depth: 20,
      supplier: supplier
    )

    product_notebook = ProductModel.create!(
      name: 'Notebook i5 16GB RAM', sku: 'NBI5-SAMSU-NOTE501KR',
      weight: 2_000, width: 40, height: 9, depth: 20,
      supplier: supplier
    )

    3.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: product_tv) }
    2.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: product_notebook) }

    # Act
    login_as(user)
    visit root_path
    click_on 'Aeroporto SP'

    # Assert
    within('section#stock-products') do
      expect(page).to have_content('Itens em Estoque')
      expect(page).to have_content('3 x TV 32 (TV32-SAMSU-XPTO909BB)')
      expect(page).to have_content('2 x Notebook i5 16GB RAM (NBI5-SAMSU-NOTE501KR)')
      expect(page).not_to have_content('2 x SoundBar 7.1 Surround (SB71-SAMSU-NOIZ501SA)')
    end
  end

  it 'and writes down a item' do
    # Arrange
    user = User.create!(name: 'John Doe', email: 'john@email.com', password: 'password123')

    warehouse = Warehouse.create(
      name: 'Aeroporto SP', description: 'Galpão destinado para cargas internacionais', code: 'SDU',
      address: 'Avenida do Aeroporto, 1000', city: 'Guarulhos', cep: '15000-000',
      area: 100_000
    )

    supplier = Supplier.create!(
      corporate_name: 'Samsung Electronics LTDA', brand_name: 'Samsung', registration_number: '83887616033136',
      full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP',
      email: 'sac@samsung.com'
    )

    order = Order.create!(
      warehouse: warehouse, supplier: supplier, user: user,
      estimated_delivery_date: 1.days.from_now
    )

    product_tv = ProductModel.create!(
      name: 'TV 32', sku: 'TV32-SAMSU-XPTO909BB',
      weight: 8_000, width: 70, height: 45, depth: 10,
      supplier: supplier
    )

    2.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: product_tv) }

    # Act
    login_as(user)
    visit root_path
    click_on 'Aeroporto SP'
    select 'TV 32 (TV32-SAMSU-XPTO909BB)', from: 'Item para Saída'
    fill_in 'Destinatário', with: 'Maria Ferreira'
    fill_in 'Endereço', with: 'Rua das Palmeiras, 100 - Campinas, São Paulo'
    click_on 'Confirmar Retirada'

    # Assert
    expect(current_path).to eq warehouse_path(warehouse)
    expect(page).to have_content 'Item retirado com sucesso.'
    expect(page).to have_content '1 x TV 32 (TV32-SAMSU-XPTO909BB)'
  end
end
