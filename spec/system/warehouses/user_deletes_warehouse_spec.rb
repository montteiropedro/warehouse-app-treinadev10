require 'rails_helper'

describe 'User deletes a warehouse' do
  it 'and should be successful' do
    # Arrange
    warehouse = Warehouse.create!(
      name: 'Aeroporto SP', description: 'Galpão destinado para cargas internacionais.', code: 'SDU',
      address: 'Avenida do Aeroporto, 1000', city: 'Guarulhos', cep: '15000-000',
      area: 100_000
    )

    # Act
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Remover'

    # Assert
    expect(current_path).to eq root_path

    expect(page).to have_content 'Galpão removido com sucesso.'

    expect(page).not_to have_content 'Aeroporto SP'
    expect(page).not_to have_content 'Código: SDU'
    expect(page).not_to have_content 'Cidade: Guarulhos'
    expect(page).not_to have_content 'Área: 100.000 m²'
  end

  it 'and all other warehouses should still exist' do
    # Arrange
    first_warehouse = Warehouse.create!(
      name: 'Aeroporto SP', description: 'Galpão destinado para cargas internacionais de SP.', code: 'SDU',
      address: 'Avenida do Aeroporto SP, 1000', city: 'Guarulhos', cep: '15000-000',
      area: 100_000
    )

    second_warehouse = Warehouse.create!(
      name: 'Galpão BH', description: 'Galpão de Belo Horizonte.', code: 'BHZ',
      address: 'Avenida Tira Dentes, 35', city: 'Belo Horizonte', cep: '30200-000',
      area: 50_000
    )
    # Act
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Remover'

    # Assert
    expect(current_path).to eq root_path

    expect(page).to have_content 'Galpão removido com sucesso.'

    expect(page).to have_content 'Galpão BH'
    expect(page).to have_content 'Código: BHZ'
    expect(page).to have_content 'Cidade: Belo Horizonte'
    expect(page).to have_content 'Área: 50.000 m²'
  end
end
