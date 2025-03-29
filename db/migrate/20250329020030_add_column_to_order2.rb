class AddColumnToOrder2 < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :change, :decimal, precision: 5, scale: 2, min: 0.00
  end
end
