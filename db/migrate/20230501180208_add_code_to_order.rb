class AddCodeToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :code, :string
  end

  add_index :orders, :code, unique: true
end
