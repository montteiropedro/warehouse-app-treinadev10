require 'rails_helper'

describe 'User visits warehouse details page' do
  it 'and should see additional information' do
    # Arrange
    Warehouse.create(
      name: 'Aeroporto SP', description: 'Galpão destinado para cargas internacionais', code: 'SDU',
      address: 'Avenida do Aeroporto, 1000', city: 'Guarulhos', cep: '15000-000',
      area: 100_000
    )

    # Act
    visit root_path
    click_on 'Aeroporto SP'

    # Assert
    expect(page).to have_content 'Galpão SDU'
    expect(page).to have_content 'Nome: Aeroporto SP'
    expect(page).to have_content 'Cidade: Guarulhos'
    expect(page).to have_content 'Área: 100.000 m²'
    expect(page).to have_content 'Endereço: Avenida do Aeroporto, 1000 - CEP: 15000-000'
    expect(page).to have_content 'Descrição: Galpão destinado para cargas internacionais'
  end

  it 'and should be able to return to the initial page' do
    # Arrange
    Warehouse.create(
      name: 'Aeroporto SP', description: 'Galpão destinado para cargas internacionais', code: 'SDU',
      address: 'Avenida do Aeroporto, 1000', city: 'Guarulhos', cep: '15000-000',
      area: 100_000
    )

    # Act
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Galpões & Estoque'

    # Assert
    expect(current_path).to eq root_path
  end
end
