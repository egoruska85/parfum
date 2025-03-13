class CreateProductdiscounts < ActiveRecord::Migration[7.0]
  def change
    create_table :productdiscounts do |t|
      t.string :value

      t.timestamps
    end
  end
end
