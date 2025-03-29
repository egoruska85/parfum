class AddColumnToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :telegram, :boolean
    add_column :users, :whatsapp, :boolean
    add_column :users, :imo, :boolean
    add_column :users, :delivery_man, :boolean
  end
end
