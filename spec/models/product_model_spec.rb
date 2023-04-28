require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'should return false when name is empty' do
        # Arrange
        supplier = Supplier.create!(
          corporate_name: 'Samsung Electronics LTDA', brand_name: 'Samsung', registration_number: '83887616033136',
          full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP',
          email: 'sac@samsung.com'
        )

        product_model = ProductModel.new(
          name: '', sku: 'TV32-SAMSU-XPTO909BB',
          weight: 8_000, width: 70, height: 45, depth: 10,
          supplier: supplier
        )

        # Act
        result = product_model.valid?

        # Assert
        expect(result).to be false
      end

      it 'should return false when SKU is empty' do
        # Arrange
        supplier = Supplier.create!(
          corporate_name: 'Samsung Electronics LTDA', brand_name: 'Samsung', registration_number: '83887616033136',
          full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP',
          email: 'sac@samsung.com'
        )

        product_model = ProductModel.new(
          name: 'TV 32', sku: '',
          weight: 8_000, width: 70, height: 45, depth: 10,
          supplier: supplier
        )

        # Act
        result = product_model.valid?

        # Assert
        expect(result).to be false
      end

      it 'should return false when weight is empty' do
        # Arrange
        supplier = Supplier.create!(
          corporate_name: 'Samsung Electronics LTDA', brand_name: 'Samsung', registration_number: '83887616033136',
          full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP',
          email: 'sac@samsung.com'
        )

        product_model = ProductModel.new(
          name: 'TV 32', sku: 'TV32-SAMSU-XPTO909BB',
          weight: '', width: 70, height: 45, depth: 10,
          supplier: supplier
        )

        # Act
        result = product_model.valid?

        # Assert
        expect(result).to be false
      end

      it 'should return false when width is empty' do
        # Arrange
        supplier = Supplier.create!(
          corporate_name: 'Samsung Electronics LTDA', brand_name: 'Samsung', registration_number: '83887616033136',
          full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP',
          email: 'sac@samsung.com'
        )

        product_model = ProductModel.new(
          name: 'TV 32', sku: 'TV32-SAMSU-XPTO909BB',
          weight: 8_000, width: '', height: 45, depth: 10,
          supplier: supplier
        )

        # Act
        result = product_model.valid?

        # Assert
        expect(result).to be false
      end

      it 'should return false when height is empty' do
        # Arrange
        supplier = Supplier.create!(
          corporate_name: 'Samsung Electronics LTDA', brand_name: 'Samsung', registration_number: '83887616033136',
          full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP',
          email: 'sac@samsung.com'
        )

        product_model = ProductModel.new(
          name: 'TV 32', sku: 'TV32-SAMSU-XPTO909BB',
          weight: 8_000, width: 70, height: '', depth: 10,
          supplier: supplier
        )

        # Act
        result = product_model.valid?

        # Assert
        expect(result).to be false
      end

      it 'should return false when depth is empty' do
        # Arrange
        supplier = Supplier.create!(
          corporate_name: 'Samsung Electronics LTDA', brand_name: 'Samsung', registration_number: '83887616033136',
          full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP',
          email: 'sac@samsung.com'
        )

        product_model = ProductModel.new(
          name: 'TV 32', sku: 'TV32-SAMSU-XPTO909BB',
          weight: 8_000, width: 70, height: 45, depth: '',
          supplier: supplier
        )

        # Act
        result = product_model.valid?

        # Assert
        expect(result).to be false
      end

      it 'should return false when supplier is empty' do
        # Arrange
        supplier = Supplier.create!(
          corporate_name: 'Samsung Electronics LTDA', brand_name: 'Samsung', registration_number: '83887616033136',
          full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP',
          email: 'sac@samsung.com'
        )

        product_model = ProductModel.new(
          name: 'TV 32', sku: 'TV32-SAMSU-XPTO909BB',
          weight: 8_000, width: 70, height: 45, depth: 10,
          supplier: nil
        )

        # Act
        result = product_model.valid?

        # Assert
        expect(result).to be false
      end
    end

    context 'uniqueness' do
      it 'should return false when SKU is alredy in use' do
        # Arrange
        supplier = Supplier.create!(
          corporate_name: 'Samsung Electronics LTDA', brand_name: 'Samsung', registration_number: '83887616033136',
          full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP',
          email: 'sac@samsung.com'
        )

        first_product_model = ProductModel.create!(
          name: 'TV 40', sku: 'TV32-SAMSU-XPTO909BB',
          weight: 8_000, width: 70, height: 45, depth: 10,
          supplier: supplier
        )

        second_product_model = ProductModel.new(
          name: 'TV 32', sku: 'TV32-SAMSU-XPTO909BB',
          weight: 3_000, width: 80, height: 15, depth: 20,
          supplier: supplier
        )

        # Act
        result = second_product_model.valid?

        # Assert
        expect(result).to be false
      end
    end

    context 'length' do
      it 'should return false when SKU length is not 20' do
        # Arrange
        supplier = Supplier.create!(
          corporate_name: 'Samsung Electronics LTDA', brand_name: 'Samsung', registration_number: '83887616033136',
          full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP',
          email: 'sac@samsung.com'
        )

        product_model = ProductModel.new(
          name: 'TV 40', sku: 'TV32-SAMS-XPTO',
          weight: 8_000, width: 70, height: 45, depth: 10,
          supplier: supplier
        )

        # Act
        result = product_model.valid?

        # Assert
        expect(result).to be false
      end
    end

    context 'numericality' do
      it 'should return false when weight is less than or equal to 0' do
        # Arrange
        supplier = Supplier.create!(
          corporate_name: 'Samsung Electronics LTDA', brand_name: 'Samsung', registration_number: '83887616033136',
          full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP',
          email: 'sac@samsung.com'
        )

        product_model = ProductModel.new(
          name: 'TV 40', sku: 'TV32-SAMS-XPTO',
          weight: 0, width: 70, height: 45, depth: 10,
          supplier: supplier
        )

        # Act
        result = product_model.valid?

        # Assert
        expect(result).to be false
      end

      it 'should return false when width is less than or equal to 0' do
        # Arrange
        supplier = Supplier.create!(
          corporate_name: 'Samsung Electronics LTDA', brand_name: 'Samsung', registration_number: '83887616033136',
          full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP',
          email: 'sac@samsung.com'
        )

        product_model = ProductModel.new(
          name: 'TV 40', sku: 'TV32-SAMS-XPTO',
          weight: 8_000, width: 0, height: 45, depth: 10,
          supplier: supplier
        )

        # Act
        result = product_model.valid?

        # Assert
        expect(result).to be false
      end

      it 'should return false when height is less than or equal to 0' do
        # Arrange
        supplier = Supplier.create!(
          corporate_name: 'Samsung Electronics LTDA', brand_name: 'Samsung', registration_number: '83887616033136',
          full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP',
          email: 'sac@samsung.com'
        )

        product_model = ProductModel.new(
          name: 'TV 40', sku: 'TV32-SAMS-XPTO',
          weight: 8_000, width: 70, height: 0, depth: 10,
          supplier: supplier
        )

        # Act
        result = product_model.valid?

        # Assert
        expect(result).to be false
      end

      it 'should return false when depth is less than or equal to 0' do
        # Arrange
        supplier = Supplier.create!(
          corporate_name: 'Samsung Electronics LTDA', brand_name: 'Samsung', registration_number: '83887616033136',
          full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP',
          email: 'sac@samsung.com'
        )

        product_model = ProductModel.new(
          name: 'TV 40', sku: 'TV32-SAMS-XPTO',
          weight: 8_000, width: 70, height: 45, depth: 0,
          supplier: supplier
        )

        # Act
        result = product_model.valid?

        # Assert
        expect(result).to be false
      end
    end
  end
end
