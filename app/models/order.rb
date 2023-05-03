class Order < ApplicationRecord
  require 'securerandom'

  belongs_to :warehouse
  belongs_to :supplier
  belongs_to :user

  before_validation :set_code

  validates :code, :estimated_delivery_date, presence: true
  validates :estimated_delivery_date, comparison: { greater_than: Date.today, message: 'precisa ser futura' }

  private

  def set_code
    self.code = SecureRandom.alphanumeric(10).upcase
  end
end
