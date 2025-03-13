class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :product_code
      t.text :desc_ru
      t.text :desc_tm
      t.string :price
      t.references :gender, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.references :productdiscount, null: false, foreign_key: true
      t.references :country, null: false, foreign_key: true
      t.references :brand, null: false, foreign_key: true

      t.timestamps
    end
  end
end
