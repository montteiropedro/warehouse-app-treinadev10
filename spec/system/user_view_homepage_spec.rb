require 'rails_helper'

describe 'User visits the initial page' do
  it 'and sees the app name "Galpões & Estoque"' do
    # Arrange (pass)

    # Act
    visit root_path

    # Assert
    expect(page).to have_content 'Galpões & Estoque'
  end

  it 'and sees all registered warehouses' do
    # Arrange
    Warehouse.create(
      name: 'Rio', description: 'Galpão do Rio de Janeiro', code: 'SDU',
      address: 'Avenida do Museu do Amanhã, 1000', city: 'Rio de Janeiro', cep: '20100-000',
      area: 60_000
    )
    Warehouse.create(
      name: 'Maceio', description: 'Galpão de Maceio', code: 'MCZ',
      address: 'Avenida Atlantica, 50', city: 'Maceio', cep: '80000-000',
      area: 50_000
    )

    # Act
    visit root_path

    # Assert
    expect(page).not_to have_content 'Não existem galpões cadastrados'

    expect(page).to have_content 'Rio'
    expect(page).to have_content 'Código: SDU'
    expect(page).to have_content 'Cidade: Rio de Janeiro'
    expect(page).to have_content 'Área: 60.000 m²'

    expect(page).to have_content 'Maceio'
    expect(page).to have_content 'Código: MCZ'
    expect(page).to have_content 'Cidade: Maceio'
    expect(page).to have_content 'Área: 50.000 m²'
  end

  it 'and there is no warehouses registered' do
    # Arrange (pass)

    # Act
    visit root_path

    # Assert
    expect(page).to have_content 'Não existem galpões cadastrados' 
  end
end
