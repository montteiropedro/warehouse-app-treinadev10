class ProductModel < ApplicationRecord
  belongs_to :supplier, required: true
  has_many :order_items
  has_many :orders, through: :order_items

  validates :name, :sku, :weight, :width, :height, :depth, presence: true
  validates :sku, length: { is: 20 }
  validates :sku, uniqueness: true
  validates :weight, :width, :height, :depth, numericality: { only_integer: true, greater_than: 0 }
end
