require 'rails_helper'

describe 'User registers a product model' do
  it 'from product model page' do
    # Arrange (pass)

    # Act
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar Modelo de Produto'

    # Assert
    expect(current_path).to eq new_product_model_path

    expect(page).to have_field 'Nome'
    expect(page).to have_field 'SKU'
    expect(page).to have_field 'Peso'
    expect(page).to have_field 'Largura'
    expect(page).to have_field 'Altura'
    expect(page).to have_field 'Profundidade'
    expect(page).to have_field 'Fornecedor'
  end

  it 'and should be successful' do
    # Arrange
    Supplier.create!(
      corporate_name: 'Samsung Electronics LTDA', brand_name: 'Samsung', registration_number: '83887616033136',
      full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP',
      email: 'sac@samsung.com'
    )

    Supplier.create!(
      corporate_name: 'LG Electronics LTDA', brand_name: 'LG', registration_number: '55686169035000',
      full_address: 'Av Ibirapuera, 300', city: 'São Paulo', state: 'SP',
      email: 'contato@lg.com'
    )

    # Act
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar Modelo de Produto'

    fill_in 'Nome', with: 'TV 32'
    fill_in 'SKU', with: 'TV32-SAMSU-XPTO909BB'
    fill_in 'Peso', with: 8_000
    fill_in 'Largura', with: 70
    fill_in 'Altura', with: 45
    fill_in 'Profundidade', with: 10
    select 'Samsung', from: 'Fornecedor'
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Modelo de produto cadastrado com sucesso.'
  end

  it 'with incomplete data and should be unsuccessful' do
    # Arrange
    supplier = Supplier.create!(
      corporate_name: 'Samsung Electronics LTDA', brand_name: 'Samsung', registration_number: '83887616033136',
      full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP',
      email: 'sac@samsung.com'
    )

    # Act
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar Modelo de Produto'

    fill_in 'Nome', with: ''
    fill_in 'SKU', with: ''
    select 'Por favor selecione', from: 'Fornecedor'
    click_on 'Enviar'

    # Assert
    expect(current_path).to eq product_models_path

    expect(page).to have_content 'Falha ao cadastrar o modelo de produto.'

    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'SKU não pode ficar em branco'
    expect(page).to have_content 'Fornecedor é obrigatório(a)'
  end
end
