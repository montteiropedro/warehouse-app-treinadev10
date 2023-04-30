# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Users
user = User.create!(name: 'John Doe', email: 'john@email.com', password: 'password123')

# Warehouses
rio_warehouse = Warehouse.create!(
  name: 'Galpão Rio', description: 'Galpão do Rio de Janeiro', code: 'SDU',
  address: 'Avenida do Museu do Amanhã, 1000', city: 'Rio de Janeiro', cep: '20100-000',
  area: 60_000
)

Warehouse.create!(
  name: 'Galpão Maceio', description: 'Galpão de cidade de Maceio', code: 'MCZ',
  address: 'Avenida Atlantica, 50', city: 'Maceio', cep: '80000-000',
  area: 50_000
)

# Suppliers
samsung_supplier = Supplier.create!(
  corporate_name: 'Samsung Electronics LTDA', brand_name: 'Samsung', registration_number: '43447216000102',
  full_address: 'Av Paulista, 100', city: 'São Paulo', state: 'SP',
  email: 'sac@samsung.com'
)

Supplier.create!(
  corporate_name: 'LG Electronics LTDA', brand_name: 'LG', registration_number: '16074559000104',
  full_address: 'Av das Américas, 1000', city: 'Rio de Janeiro', state: 'RJ',
  email: 'contato@lg.com'
)

# Product Models
ProductModel.create!(
  name: 'TV 32', sku: 'TV32-SAMSU-XPTO909BB',
  weight: 8_000, width: 70, height: 45, depth: 10,
  supplier: samsung_supplier
)

ProductModel.create!(
  name: 'SoundBar 7.1 Surround', sku: 'SB71-SAMSU-NOIZ501SA',
  weight: 3_000, width: 80, height: 15, depth: 20,
  supplier: samsung_supplier
)

# Orders
Order.create!(
  warehouse: rio_warehouse, supplier: samsung_supplier, user: user, estimated_delivery_date: '20/12/2023' 
)
