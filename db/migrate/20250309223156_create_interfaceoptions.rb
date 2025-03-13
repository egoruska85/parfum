class CreateInterfaceoptions < ActiveRecord::Migration[7.0]
  def change
    create_table :interfaceoptions do |t|
      t.string :background
      t.string :navbar_color
      t.integer :quantity_products_on_pages

      t.timestamps
    end
  end
end
