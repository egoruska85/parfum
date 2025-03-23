class AddColumnToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :for_payment, :decimal, precision: 5, scale: 2
    add_column :orders, :payment, :decimal, precision: 5, scale: 2
    add_column :orders, :canceled, :boolean
    add_column :orders, :accepted, :boolean
    add_column :orders, :sent, :boolean
    add_column :orders, :delivered, :boolean
    add_column :orders, :received, :boolean
  end
end
