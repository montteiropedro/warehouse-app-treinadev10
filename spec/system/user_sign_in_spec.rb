require 'rails_helper'

describe 'User sign-in' do
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

    # Assert
    expect(page).to have_content 'Login efetuado com sucesso.'

    within('nav') do
      expect(page).not_to have_link 'Entrar'

      expect(page).to have_content 'John Doe'
      expect(page).to have_link 'Sair'
    end
  end
end
