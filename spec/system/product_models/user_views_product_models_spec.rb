require 'rails_helper'

describe 'User views all registered product models' do
  it 'from navigation menu' do
    # Arrange (pass)

    # Act
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end

    # Assert
    expect(current_path).to eq new_user_session_path
  end

  context 'when authenticated' do
    it 'should be successful' do
      # Arrange
      user = User.create!(name: 'John Doe', email: 'john@email.com', password: 'password123')

      supplier = Supplier.create!(
        corporate_name: 'Samsung Electronics LTDA', brand_name: 'Samsung', registration_number: '83887616033136',
        full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP',
        email: 'sac@samsung.com'
      )
  
      ProductModel.create!(
        name: 'TV 32', sku: 'TV32-SAMSU-XPTO909BB',
        weight: 8_000, width: 70, height: 45, depth: 10,
        supplier: supplier
      )
  
      ProductModel.create!(
        name: 'SoundBar 7.1 Surround', sku: 'SB71-SAMSU-NOIZ501SA',
        weight: 3_000, width: 80, height: 15, depth: 20,
        supplier: supplier
      )
      
      # Act
      login_as(user)
      visit root_path
      click_on 'Modelos de Produtos'
  
      # Assert
      within('h2') do
        expect(page).to have_content 'Modelos de Produtos'
      end

      expect(page).to have_content 'TV 32'
      expect(page).to have_content 'TV32-SAMSU-XPTO909BB'
      expect(page).to have_content 'Samsung'
  
      expect(page).to have_content 'SoundBar 7.1 Surround'
      expect(page).to have_content 'SB71-SAMSU-NOIZ501SA'
      expect(page).to have_content 'Samsung'
    end
  
    it 'should see a message when there is no product model registered' do
      # Arrange
      user = User.create!(name: 'John Doe', email: 'john@email.com', password: 'password123')
  
      # Act
      login_as(user)
      visit root_path
      click_on 'Modelos de Produtos'
  
      # Assert
      expect(page).to have_content 'Não existem modelos de produtos cadastrados.'
    end
  end

  context 'when unauthenticated' do
    it 'should not be successful' do
      # Arrange (pass)
      
      # Act
      visit root_path
      click_on 'Modelos de Produtos'
  
      # Assert
      expect(current_path).to eq new_user_session_path

      expect(page).to have_content 'Para continuar, faça login ou registre-se.'
    end
  end
end
