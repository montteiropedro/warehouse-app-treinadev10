class OrderItem < ApplicationRecord
  belongs_to :product_model
  belongs_to :order

  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
end
