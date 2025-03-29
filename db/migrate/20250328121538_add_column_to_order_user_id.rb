class AddColumnToOrderUserId < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :user_id, :string
  end
end
