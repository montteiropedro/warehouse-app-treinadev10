require 'rails_helper'

describe 'User views own orders' do
  it 'and should be authenticated' do
    # Arrange (pass)

    # Act
    visit root_path
    click_on 'Meus Pedidos'

    # Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'and does not see other users orders' do
    # Arrange
    john = User.create!(name: 'John Doe', email: 'john@email.com', password: 'password123')
    steve = User.create!(name: 'Steve Gate', email: 'steve@email.com', password: 'password123')

    warehouse = Warehouse.create!(
      name: 'Galpão Rio', description: 'Galpão do Rio de Janeiro', code: 'SDU',
      address: 'Avenida do Museu do Amanhã, 1000', city: 'Rio de Janeiro', cep: '20100-000',
      area: 60_000
    )
    supplier = Supplier.create!(
      corporate_name: 'Samsung Electronics LTDA', brand_name: 'Samsung', registration_number: '43447216000102',
      full_address: 'Av Paulista, 100', city: 'São Paulo', state: 'SP',
      email: 'sac@samsung.com'
    )

    first_order = Order.create!(
      warehouse: warehouse, supplier: supplier, user: john, estimated_delivery_date: 10.days.from_now
    )
    second_order = Order.create!(
      warehouse: warehouse, supplier: supplier, user: john, estimated_delivery_date: 1.week.from_now
    )
    third_order = Order.create!(
      warehouse: warehouse, supplier: supplier, user: steve, estimated_delivery_date: 15.days.from_now
    )

    # Act
    login_as(john)
    visit root_path
    click_on 'Meus Pedidos'

    # Assert
    expect(page).to have_content first_order.code
    expect(page).to have_content second_order.code
    expect(page).not_to have_content third_order.code
  end
end
