class PersonalTag < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :operator, :boolean
    add_column :users, :administration, :boolean
  end
end
