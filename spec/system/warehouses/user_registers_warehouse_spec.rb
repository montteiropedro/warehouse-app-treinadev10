require 'rails_helper'

describe 'User registers a warehouse' do
  it 'from initial page' do
    # Arrange (pass)

    # Act
    visit root_path
    click_on 'Cadastrar Galpão'

    # Assert
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Código'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'CEP'
    expect(page).to have_field 'Área'
  end

  it 'and should be successful' do
    # Arrange

    # Act
    visit root_path
    click_on 'Cadastrar Galpão'

    fill_in 'Nome', with: 'Rio de Janeiro'
    fill_in 'Descrição', with: 'Galpão da zona portuária do Rio'
    fill_in 'Código', with: 'RIO'
    fill_in 'Endereço', with: 'Avenida do Museu do Amanhã, 1000'
    fill_in 'Cidade', with: 'Rio de Janeiro'
    fill_in 'CEP', with: '20100-000'
    fill_in 'Área', with: '32000'
    click_on 'Enviar'

    # Assert
    expect(current_path).to eq root_path

    expect(page).to have_content 'Galpão cadastrado com sucesso.'

    expect(page).to have_content 'RIO'
    expect(page).to have_content 'Rio de Janeiro'
    expect(page).to have_content '32.000 m²'
  end

  it 'with incomplete data and should be unsuccessful' do
    # Arrange
    visit root_path
    click_on 'Cadastrar Galpão'

    # Act
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Código', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'CEP', with: ''
    fill_in 'Área', with: ''
    click_on 'Enviar'

    # Assert
    expect(current_path).to eq warehouses_path

    expect(page).to have_content 'Galpão não cadastrado.'
    
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Código não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
    expect(page).to have_content 'Cidade não pode ficar em branco'
    expect(page).to have_content 'CEP não pode ficar em branco'
    expect(page).to have_content 'Área não pode ficar em branco'
  end

  it 'and should be able to return to the initial page' do
    # Arrange (pass)

    # Act
    visit root_path
    click_on 'Cadastrar Galpão'
    click_on 'Galpões & Estoque'

    # Assert
    expect(current_path).to eq root_path
  end
end
