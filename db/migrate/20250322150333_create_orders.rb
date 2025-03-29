class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :user_id
      t.string :username
      t.string :phone
      t.integer :post_code
      t.string :city
      t.string :district
      t.string :street
      t.string :house
      t.string :flat

      t.timestamps
    end
  end
end
