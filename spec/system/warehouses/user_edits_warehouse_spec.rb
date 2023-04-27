require 'rails_helper'

describe 'User edits a warehouse' do
  it 'from warehouse details page' do
    # Arrange
    warehouse = Warehouse.create!(
      name: 'Aeroporto SP', description: 'Galpão destinado para cargas internacionais.', code: 'SDU',
      address: 'Avenida do Aeroporto, 1000', city: 'Guarulhos', cep: '15000-000',
      area: 100_000
    )

    # Act
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Editar'

    # Assert
    expect(current_path).to eq edit_warehouse_path(warehouse.id)

    expect(page).to have_content 'Editar Galpão'

    expect(page).to have_field 'Nome', with: 'Aeroporto SP'
    expect(page).to have_field 'Descrição', with: 'Galpão destinado para cargas internacionais.'
    expect(page).to have_field 'Código', with: 'SDU'
    expect(page).to have_field 'Endereço', with: 'Avenida do Aeroporto, 1000'
    expect(page).to have_field 'Cidade', with: 'Guarulhos'
    expect(page).to have_field 'CEP', with: '15000-000'
    expect(page).to have_field 'Área', with: '100000'
  end

  it 'successfully' do
    # Arrange
    warehouse = Warehouse.create!(
      name: 'Aeroporto SP', description: 'Galpão destinado para cargas internacionais.', code: 'SDU',
      address: 'Avenida do Aeroporto, 1000', city: 'Guarulhos', cep: '15000-000',
      area: 100_000
    )

    # Act
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Editar'

    fill_in 'Nome', with: 'Galpão Internacional'
    fill_in 'Endereço', with: 'Avenida dos Galpões, 500'
    fill_in 'CEP', with: '16000-000'
    fill_in 'Área', with: '200000'
    click_on 'Enviar'

    # Assert
    expect(current_path).to eq warehouse_path(warehouse.id)

    expect(page).to have_content 'Galpão atualizado com sucesso.'

    expect(page).to have_content 'Nome: Galpão Internacional'
    expect(page).to have_content 'Descrição: Galpão destinado para cargas internacionais.'
    expect(page).to have_content 'Código: SDU'
    expect(page).to have_content 'Endereço: Avenida dos Galpões, 500'
    expect(page).to have_content 'Cidade: Guarulhos'
    expect(page).to have_content 'CEP: 16000-000'
    expect(page).to have_content 'Área: 200.000 m²'
  end

  it 'keeps required fields' do
    # Arrange
    warehouse = Warehouse.create!(
      name: 'Aeroporto SP', description: 'Galpão destinado para cargas internacionais.', code: 'SDU',
      address: 'Avenida do Aeroporto, 1000', city: 'Guarulhos', cep: '15000-000',
      area: 100_000
    )

    # Act
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Editar'

    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Código', with: ''
    click_on 'Enviar'

    # Assert
    expect(current_path).to eq warehouse_path(warehouse.id)

    expect(page).to have_content 'Falha ao atualizar o galpão.'
    
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Código não pode ficar em branco'
  end
end
