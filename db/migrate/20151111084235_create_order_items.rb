class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.string :description
      t.string :item_number
      t.decimal :unit_price
      t.integer :quantity
      t.references :order, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
