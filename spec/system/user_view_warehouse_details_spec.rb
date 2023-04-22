require 'rails_helper'

describe 'User visits warehouse details page' do
  it 'and sees additional information' do
    # Arrange
    Warehouse.create(
      name: 'Aeroporto SP', code: 'SDU', city: 'Guarulhos', area: 100_000,
      address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
      description: 'Galpão destinado para cargas internacionais'
    )

    # Act
    visit(root_path)
    click_on('Aeroporto SP')

    # Assert
    expect(page).to have_content('Galpão SDU')
    expect(page).to have_content('Nome: Aeroporto SP')
    expect(page).to have_content('Cidade: Guarulhos')
    expect(page).to have_content('Área: 100.000 m²')
    expect(page).to have_content('Endereço: Avenida do Aeroporto, 1000 - CEP: 15000-000')
    expect(page).to have_content('Descrição: Galpão destinado para cargas internacionais')
  end

  it 'and returns to initial page' do
    # Arrange (pass)
    Warehouse.create(
      name: 'Aeroporto SP', code: 'SDU', city: 'Guarulhos', area: 100_000,
      address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
      description: 'Galpão destinado para cargas internacionais'
    )

    # Act
    visit(root_path)
    click_on('Aeroporto SP')
    click_on('Voltar')

    # Assert
    expect(current_path).to eq(root_path)
  end
end
