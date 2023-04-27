require 'rails_helper'

describe 'User deletes a supplier' do
  pending 'and should be successful' do
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
    click_on 'Remover'

    # Assert
    expect(current_path).to eq suppliers_path

    expect(page).to have_content 'Fornecedor removido com sucesso.'

    expect(page).not_to have_content 'ACME'
    expect(page).not_to have_content 'Bauru - SP'
  end

  pending 'and all other suppliers should still exist' do
    # Arrange
    first_supplier = Supplier.create!(
      corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
      full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP',
      email: 'contato@acme.com'
    )

    second_supplier = Supplier.create!(
      corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '16074559000104',
      full_address: 'Torre da Indústria, 1000', city: 'Teresina', state: 'PI',
      email: 'vendas@spark.com.br'
    )

    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Remover'

    # Assert
    expect(page).to have_content 'Spark'
    expect(page).to have_content 'Teresina - PI'
  end
end
