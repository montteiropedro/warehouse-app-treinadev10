require 'rails_helper'

describe 'User views all registered suppliers' do
  it 'from suppliers page' do
    # Arrange (pass)

    # Act
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end

    # Assert
    expect(current_path).to eq suppliers_path

    within('h2') do
      expect(page).to have_content 'Fornecedores'
    end
  end

  it 'and should be successful' do
    # Arrange
    Supplier.create!(
      corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102',
      full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP',
      email: 'contato@acme.com'
    )

    Supplier.create!(
      corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '16074559000104',
      full_address: 'Torre da Indústria, 1000', city: 'Teresina', state: 'PI',
      email: 'vendas@spark.com.br'
    )

    # Act
    visit root_path
    click_on 'Fornecedores'

    # Assert
    expect(page).to have_content 'ACME'
    expect(page).to have_content 'Bauru - SP'

    expect(page).to have_content 'Spark'
    expect(page).to have_content 'Teresina - PI'
  end

  it 'and should see a message when there is no supplier registered' do
    # Arrange (pass)

    # Act
    visit root_path
    click_on 'Fornecedores'

    # Assert
    expect(page).to have_content 'Não existem fornecedores cadastrados.'
  end
end
