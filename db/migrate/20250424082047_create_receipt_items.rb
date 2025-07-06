class CreateReceiptItems < ActiveRecord::Migration[7.0]
  def change
    create_table :receipt_items do |t|
      t.belongs_to :receipt, null: false, foreign_key: true
      t.belongs_to :product, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :price

      t.timestamps
    end
  end
end
