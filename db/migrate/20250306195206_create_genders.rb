class CreateGenders < ActiveRecord::Migration[7.0]
  def change
    create_table :genders do |t|
      t.string :name
      t.string :name_tm

      t.timestamps
    end
  end
end
