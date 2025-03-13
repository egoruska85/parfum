class CreateGeneraldiscounts < ActiveRecord::Migration[7.0]
  def change
    create_table :generaldiscounts do |t|
      t.string :value

      t.timestamps
    end
  end
end
