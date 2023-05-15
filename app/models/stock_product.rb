class StockProduct < ApplicationRecord
  belongs_to :warehouse
  belongs_to :order
  belongs_to :product_model
  has_one :stock_product_destination

  before_validation :set_serial_number, on: :create

  def description
    "#{self.product_model.name} (#{self.product_model.sku})"
  end

  def available?
    self.stock_product_destination.present?
  end

  private

  def set_serial_number
    self.serial_number = SecureRandom.alphanumeric(20).upcase if self.serial_number.nil?
  end
end
