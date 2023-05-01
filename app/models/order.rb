class Order < ApplicationRecord
  require 'securerandom'

  belongs_to :warehouse
  belongs_to :supplier
  belongs_to :user

  before_validation :set_code

  validates :code, presence: true
  validates :estimated_delivery_date, comparison: { greater_than: Date.today }

  private

  def set_code
    self.code = SecureRandom.alphanumeric(10).upcase
  end
end
