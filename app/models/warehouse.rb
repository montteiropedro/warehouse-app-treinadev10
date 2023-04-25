class Warehouse < ApplicationRecord
  validates :name, :description, :code, :address, :city, :cep, :area, presence: true
  validates :code, length: { is: 3 }
end
