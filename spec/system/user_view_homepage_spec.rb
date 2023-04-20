require 'rails_helper'

describe 'User visits the initial page' do
  it 'and sees the app name "Galpões & Estoque"' do
    # Arrange (pass)
    # Act
    visit('/')

    # Assert
    expect(page).to have_content('Galpões & Estoque')
  end
end
