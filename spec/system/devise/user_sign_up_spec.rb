require 'rails_helper'

describe 'User registration (devise)' do
  it 'from navigation menu' do
    # Arrange (pass)

    # Act
    visit root_path
    click_on 'Entrar'
    click_on 'Criar uma conta'

    # Assert
    expect(current_path).to eq new_user_registration_path

    within('form') do
      expect(page).to have_field 'Nome'
      expect(page).to have_field 'E-mail'
      expect(page).to have_field 'Senha'
      expect(page).to have_field 'Confirme sua senha'
    end
  end

  it 'should be successful' do
    # Arrange (pass)

    # Act
    visit root_path
    click_on 'Entrar'
    click_on 'Criar uma conta'

    within('form') do
      fill_in 'Nome', with: 'John Doe'
      fill_in 'E-mail', with: 'john@email.com'
      fill_in 'Senha', with: 'password123'
      fill_in 'Confirme sua senha', with: 'password123'
      click_on 'Cadastrar'
    end

    # Assert
    expect(current_path).to eq root_path

    expect(page).to have_content 'Cadastro realizado com sucesso.'
  end

  it 'should be unsuccessful with incorrect data' do
    # Arrange (pass)

    # Act
    visit root_path
    click_on 'Entrar'
    click_on 'Criar uma conta'

    within('form') do
      fill_in 'Nome', with: 'John Doe'
      fill_in 'E-mail', with: 'john@email.com'
      fill_in 'Senha', with: 'pass1'
      fill_in 'Confirme sua senha', with: 'pass1'
      click_on 'Cadastrar'
    end

    # Assert
    expect(current_path).to eq user_registration_path

    expect(page).to have_content 'Não foi possível salvar usuário'
  end

  it 'should be unsuccessful with incomplete data' do
    # Arrange (pass)

    # Act
    visit root_path
    click_on 'Entrar'
    click_on 'Criar uma conta'

    within('form') do
      fill_in 'Nome', with: ''
      fill_in 'E-mail', with: ''
      fill_in 'Senha', with: ''
      fill_in 'Confirme sua senha', with: ''
      click_on 'Cadastrar'
    end

    # Assert
    expect(current_path).to eq user_registration_path

    expect(page).to have_content 'Não foi possível salvar usuário'
  end
end
