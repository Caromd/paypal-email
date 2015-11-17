class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :transaction_id
      t.string :paypal_id
      t.string :paypal_email
      t.datetime :date_received
      t.string :shipping_name
      t.string :shipping_address1
      t.string :shipping_address2
      t.string :shipping_address3
      t.string :shipping_address4
      t.string :shipping_address5
      t.decimal :payment_total
      t.decimal :payment_subtotal
      t.decimal :shipping_total
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
