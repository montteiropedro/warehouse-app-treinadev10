require 'rails_helper'

describe 'User session (devise)' do
  it 'from navigation menu' do
    # Arrange (pass)

    # Act
    visit root_path
    click_on 'Entrar'

    # Assert
    expect(current_path).to eq new_user_session_path

    within('form') do
      expect(page).to have_field 'E-mail'
      expect(page).to have_field 'Senha'
    end
  end

  context 'sign in' do
    it 'should be successful with correct data' do
      # Arrange
      User.create!(name: 'John Doe', email: 'john@email.com', password: 'password123')

      # Act
      visit root_path
      click_on 'Entrar'

      within('form') do
        fill_in 'E-mail', with: 'john@email.com'
        fill_in 'Senha', with: 'password123'
        click_on 'Entrar'
      end

      # Assert
      expect(page).to have_content 'Login efetuado com sucesso.'

      within('nav') do
        expect(page).not_to have_link 'Entrar'

        expect(page).to have_content 'John Doe'
        expect(page).to have_button 'Sair'
      end
    end

    it 'should be unsuccessful with incorrect data' do
      # Arrange
      User.create!(name: 'John Doe', email: 'john@email.com', password: 'password123')

      # Act
      visit root_path
      click_on 'Entrar'

      within('form') do
        fill_in 'E-mail', with: 'wrong_john@email.com'
        fill_in 'Senha', with: 'wrongpass123'
        click_on 'Entrar'
      end

      # Assert
      expect(page).to have_content 'E-mail ou senha inválidos.'

      within('nav') do
        expect(page).not_to have_content 'John Doe'
        expect(page).not_to have_button 'Sair'

        expect(page).to have_link 'Entrar'
      end
    end

    it 'should be unsuccessful with incomplete data' do
      # Arrange
      User.create!(name: 'John Doe', email: 'john@email.com', password: 'password123')

      # Act
      visit root_path
      click_on 'Entrar'

      within('form') do
        fill_in 'E-mail', with: ''
        fill_in 'Senha', with: ''
        click_on 'Entrar'
      end

      # Assert
      expect(page).to have_content 'E-mail ou senha inválidos.'

      within('nav') do
        expect(page).not_to have_content 'John Doe'
        expect(page).not_to have_button 'Sair'

        expect(page).to have_link 'Entrar'
      end
    end
  end
  
  context 'sign out' do
    it 'should be successful' do
      # Arrange
      User.create!(name: 'John Doe', email: 'john@email.com', password: 'password123')

      # Act
      visit root_path
      click_on 'Entrar'

      within('form') do
        fill_in 'E-mail', with: 'john@email.com'
        fill_in 'Senha', with: 'password123'
        click_on 'Entrar'
      end

      click_on 'Sair'

      # Assert
      expect(page).to have_content 'Logout efetuado com sucesso.'

      within('nav') do
        expect(page).not_to have_content 'John Doe'
        expect(page).not_to have_button 'Sair'

        expect(page).to have_link 'Entrar'
      end
    end
  end
end
