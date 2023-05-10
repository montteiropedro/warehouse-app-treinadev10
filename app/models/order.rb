class Order < ApplicationRecord
  belongs_to :warehouse
  belongs_to :supplier
  belongs_to :user
  has_many :order_items
  has_many :product_models, through: :order_items

  enum status: { pending: 0, delivered: 5, canceled: 9 }

  before_validation :set_code

  validates :code, :estimated_delivery_date, presence: true
  validates :estimated_delivery_date, comparison: { greater_than: Date.today, message: 'precisa ser futura' }

  private

  def set_code
    self.code = SecureRandom.alphanumeric(10).upcase
  end
end
