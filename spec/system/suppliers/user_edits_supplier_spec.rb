require 'rails_helper'

describe 'User edits a supplier' do
  it 'from supplier details page' do
    # Arrange
    supplier = Supplier.create!(
      corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
      full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP',
      email: 'contato@acme.com'
    )

    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Editar'

    # Assert
    expect(current_path).to eq edit_supplier_path(supplier.id)

    expect(page).to have_content 'Editar Fornecedor'

    expect(page).to have_field 'Nome Fantasia', with: 'ACME'
    expect(page).to have_field 'Razão Social', with: 'ACME LTDA'
    expect(page).to have_field 'CNPJ', with: '43447216000102'
    expect(page).to have_field 'Endereço', with: 'Av das Palmas, 100'
    expect(page).to have_field 'Cidade', with: 'Bauru'
    expect(page).to have_field 'Estado', with: 'SP'
    expect(page).to have_field 'E-mail', with: 'contato@acme.com'
  end

  it 'and should be successful' do
    # Arrange
    supplier = Supplier.create!(
      corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
      full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP',
      email: 'contato@acme.com'
    )

    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Editar'

    fill_in 'Endereço', with: 'Av Paulista, 650'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'E-mail', with: 'contato@acme.com.br'
    click_on 'Enviar'

    # Assert
    expect(current_path).to eq supplier_path(supplier.id)

    expect(page).to have_content 'Fornecedor atualizado com sucesso.'

    expect(page).to have_content 'ACME LTDA'
    expect(page).to have_content 'CNPJ: 43447216000102'
    expect(page).to have_content 'Endereço: Av Paulista, 650 - São Paulo, SP'
    expect(page).to have_content 'E-mail: contato@acme.com.br'
  end

  it 'and should keep required fields' do
    # Arrange
    supplier = Supplier.create!(
      corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
      full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP',
      email: 'contato@acme.com'
    )

    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Editar'

    fill_in 'Endereço', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'E-mail', with: ''
    click_on 'Enviar'

    # Assert
    expect(current_path).to eq supplier_path(supplier.id)

    expect(page).to have_content 'Falha ao atualizar o fornecedor.'

    expect(page).to have_content 'Endereço não pode ficar em branco'
    expect(page).to have_content 'Cidade não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
  end

  it 'and should be able to return to the initial page' do
    # Arrange
    Supplier.create!(
      corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
      full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP',
      email: 'contato@acme.com'
    )

    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Galpões & Estoque'

    # Assert
    expect(current_path).to eq root_path
  end
end
