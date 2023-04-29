require 'rails_helper'

describe 'User views all registered product models' do
  context 'when authenticated' do
    it 'should see additional information' do
      # Arrange
      user = User.create!(name: 'John Doe', email: 'john@email.com', password: 'password123')

      supplier = Supplier.create!(
        corporate_name: 'Samsung Electronics LTDA', brand_name: 'Samsung', registration_number: '83887616033136',
        full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP',
        email: 'sac@samsung.com'
      )
  
      product_model = ProductModel.create!(
        name: 'TV 32', sku: 'TV32-SAMSU-XPTO909BB',
        weight: 8_000, width: 70, height: 45, depth: 10,
        supplier: supplier
      )
  
      # Act
      login_as(user)
      visit root_path
      click_on 'Modelos de Produtos'
      click_on 'TV 32'
  
      # Assert
      expect(current_path).to eq product_model_path(product_model)
  
      expect(page).to have_content 'TV 32'
      expect(page).to have_content 'SKU: TV32-SAMSU-XPTO909BB'
      expect(page).to have_content 'Peso: 8.000g'
      expect(page).to have_content 'Largura: 70cm'
      expect(page).to have_content 'Altura: 45cm'
      expect(page).to have_content 'Profundidade: 10cm'
      expect(page).to have_content 'Fornecedor: Samsung'
    end
  
    it 'should be able to return to the initial page' do
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
  
      # Act
      login_as(user)
      visit root_path
      click_on 'Modelos de Produtos'
      click_on 'TV 32'
      click_on 'Homepage'
  
      # Assert
      expect(current_path).to eq root_path
    end
  end
  
  context 'when unauthenticated' do
    it 'should not be successful' do
      # Arrange
      supplier = Supplier.create!(
        corporate_name: 'Samsung Electronics LTDA', brand_name: 'Samsung', registration_number: '83887616033136',
        full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP',
        email: 'sac@samsung.com'
      )
  
      product_model = ProductModel.create!(
        name: 'TV 32', sku: 'TV32-SAMSU-XPTO909BB',
        weight: 8_000, width: 70, height: 45, depth: 10,
        supplier: supplier
      )
      
      # Act
      visit product_model_path(product_model)
  
      # Assert
      expect(current_path).to eq new_user_session_path

      expect(page).to have_content 'Para continuar, faça login ou registre-se.'
    end
  end
end
