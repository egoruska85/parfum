class AddColumnToOrder3 < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :ordered, :boolean
    add_column :orders, :refusal, :boolean
    add_column :orders, :closed, :boolean
  end
end
