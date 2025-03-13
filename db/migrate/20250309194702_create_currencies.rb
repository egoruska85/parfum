class CreateCurrencies < ActiveRecord::Migration[7.0]
  def change
    create_table :currencies do |t|
      t.string :name
      t.string :name_tm
      t.string :banknote

      t.timestamps
    end
  end
end
