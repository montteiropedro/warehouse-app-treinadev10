require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#description' do
    it 'should return a string having name and email' do
      # Arrange
      user = User.new(name: 'John Doe', email: 'john@email.com', password: 'password123')

      # Act
      result = user.description

      # Assert
      expect(result).to eq 'John Doe <john@email.com>'
    end
  end
end
