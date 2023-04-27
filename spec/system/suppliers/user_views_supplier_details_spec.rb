require 'rails_helper'

describe 'User visits a supplier details page' do
  it 'and should see additional information' do
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

    # Assert
    expect(page).to have_content 'ACME LTDA'
    expect(page).to have_content 'CNPJ: 43447216000102'
    expect(page).to have_content 'Endereço: Av das Palmas, 100 - Bauru, SP'
    expect(page).to have_content 'Email: contato@acme.com'
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
    click_on 'Homepage'

    # Assert
    expect(current_path).to eq root_path
  end
end
