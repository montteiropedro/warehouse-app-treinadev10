require 'rails_helper'

describe 'User searches order' do
  it 'from navigation menu' do
    # Arrange
    user = User.create!(name: 'John Doe', email: 'john@email.com', password: 'password123')

    # Act
    login_as(user)
    visit root_path

    # Assert
    within('nav') do
      expect(page).to have_field 'Buscar Pedido'
      expect(page).to have_button 'Buscar'
    end
  end

  context 'user' do
    it 'should be authenticated' do
      # Arrange (pass)
  
      # Act
      visit root_path
  
      # Assert
      within('nav') do
        expect(page).not_to have_field 'Buscar Pedido'
        expect(page).not_to have_button 'Buscar'
      end
    end
  end

  context 'when redirected to the search result page' do
    it 'should see the all the orders that have the search string in their code' do
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

      allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('SDU12345RJ')
      first_order = Order.create!(
        warehouse: first_warehouse, supplier: supplier, user: user, estimated_delivery_date: 1.day.from_now
      )
      allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('SDU67890RJ')
      second_order = Order.create!(
        warehouse: first_warehouse, supplier: supplier, user: user, estimated_delivery_date: 1.day.from_now
      )
      allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('MCZ00000AL')
      third_order = Order.create!(
        warehouse: second_warehouse, supplier: supplier, user: user, estimated_delivery_date: 1.day.from_now
      )

      # Act
      login_as(user)
      visit root_path

      fill_in 'Buscar Pedido', with: 'SDU'
      click_on 'Buscar'

      # Assert
      expect(page).to have_content "Resultado da busca por: SDU"
      expect(page).to have_content '2 pedidos encontrados.'
      expect(page).to have_link "Pedido SDU12345RJ"
      expect(page).to have_link "Pedido SDU12345RJ"
      expect(page).to have_content "Galpão Destino: SDU | Galpão Rio"
      expect(page).not_to have_link "Pedido MCZ00000AL"
      expect(page).not_to have_content "Galpão Destino: MCZ | Galpão Maceio"
    end

    it 'should see a message when the specified string does not fits in any code' do
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
        warehouse: warehouse, supplier: supplier, user: user, estimated_delivery_date: 1.day.from_now
      )

      # Act
      login_as(user)
      visit root_path

      fill_in 'Buscar Pedido', with: 'COD1235B20'
      click_on 'Buscar'

      # Assert
      expect(page).to have_content "Resultado da busca por: COD1235B20"
      expect(page).to have_content 'Não encontramos seu pedido.'
    end
  end
end
