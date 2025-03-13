class CreateCarousels < ActiveRecord::Migration[7.0]
  def change
    create_table :carousels do |t|
      t.string :title_ru
      t.string :title_tm
      t.string :desc_ru
      t.string :desc_tm

      t.timestamps
    end
  end
end
