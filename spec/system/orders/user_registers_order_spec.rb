require 'rails_helper'

describe 'User registers a order' do
  it 'from navigation menu' do
    # Arrange
    user = User.create!(name: 'John Doe', email: 'john@email.com', password: 'password123')
    
    # Act
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Registrar Pedido'
    end

    # Assert
    expect(page).not_to have_content 'Para continuar, faça login ou registre-se.'
    expect(current_path).to eq new_order_path
    expect(page).to have_field 'Galpão'
    expect(page).to have_field 'Fornecedor'
    expect(page).to have_field 'Data Prevista de Entrega'
  end

  context 'when authenticated' do
    it 'should be successful' do
      # Arrange
      user = User.create!(name: 'John Doe', email: 'john@email.com', password: 'password123')
      warehouse = Warehouse.create!(
        name: 'Galpão Rio', description: 'Galpão do Rio de Janeiro', code: 'SDU',
        address: 'Avenida do Museu do Amanhã, 1000', city: 'Rio de Janeiro', cep: '20100-000',
        area: 60_000
      )
      other_warehouse = Warehouse.create!(
        name: 'Galpão Maceio', description: 'Galpão de cidade de Maceio', code: 'MCZ',
        address: 'Avenida Atlantica, 50', city: 'Maceio', cep: '80000-000',
        area: 50_000
      )
      supplier = Supplier.create!(
        corporate_name: 'Samsung Electronics LTDA', brand_name: 'Samsung', registration_number: '43447216000102',
        full_address: 'Av Paulista, 100', city: 'São Paulo', state: 'SP',
        email: 'sac@samsung.com'
      )
      other_supplier = Supplier.create!(
        corporate_name: 'LG Electronics LTDA', brand_name: 'LG', registration_number: '16074559000104',
        full_address: 'Av das Américas, 1000', city: 'Rio de Janeiro', state: 'RJ',
        email: 'contato@lg.com'
      )
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABCDEFGHIJ')

      # Act
      login_as(user)
      visit root_path
      within('nav') do
        click_on 'Registrar Pedido'
      end

      select 'SDU | Galpão Rio', from: 'Galpão Destino'
      select 'Samsung | Samsung Electronics LTDA | CNPJ: 43447216000102', from: 'Fornecedor'
      fill_in 'Data Prevista de Entrega', with: '20/12/2024'
      click_on 'Enviar'

      # Assert
      expect(page).to have_content 'Pedido registrado com sucesso.'
      expect(page).to have_content 'Pedido ABCDEFGHIJ'
      expect(page).to have_content 'Usuário Responsável: John Doe <john@email.com>'
      expect(page).to have_content "Data Prevista de Entrega: 20/12/2024"
      expect(page).to have_content "Galpão Destino: SDU | Galpão Rio"
      expect(page).to have_content "Fornecedor: Samsung Electronics LTDA"
      expect(page).to have_content 'Situação do Pedido: Pendente'
    end

    it 'should not be successful with incomplete data' do
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

      # Act
      login_as(user)
      visit root_path
      within('nav') do
        click_on 'Registrar Pedido'
      end

      select 'Por favor selecione', from: 'Galpão Destino'
      select 'Por favor selecione', from: 'Fornecedor'
      fill_in 'Data Prevista de Entrega', with: ''
      click_on 'Enviar'

      # Assert
      expect(current_path).to eq orders_path
      expect(page).to have_content 'Falha ao registrar o pedido.'
    end

    it 'should be able to return to the initial page' do
      # Arrange
      user = User.create!(name: 'John Doe', email: 'john@email.com', password: 'password123')

      # Act
      login_as(user)
      visit root_path
      within('nav') do
        click_on 'Registrar Pedido'
      end
      click_on 'Galpões & Estoque'
  
      # Assert
      expect(current_path).to eq root_path
    end
  end

  context 'when unauthenticated' do
    it 'should not be successful' do
      # Arrange (pass)

      # Act
      visit new_order_path

      # Assert
      expect(current_path).to eq new_user_session_path
    end
  end
end
