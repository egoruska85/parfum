class CreateReceipts < ActiveRecord::Migration[7.0]
  def change
    create_table :receipts do |t|
      t.boolean :activation
      t.datetime :received_at

      t.timestamps
    end
  end
end
