require 'rails_helper'

describe 'User session with devise' do
  context 'Sign in' do
    it 'and should be successful with correct data' do
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

    it 'and should be unsuccessful with incorrect data' do
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
  end
  
  context 'Sign out' do
    it 'and should be successful' do
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
