class PersonalTagUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :personal, :boolean
  end
end
