json.array!(@orders) do |order|
  json.extract! order, :id, :transaction_id, :paypal_id, :paypal_email, :date_received, :shipping_name, :shipping_address1, :shipping_address2, :shipping_address3, :shipping_address4, :payment_total, :payment_subtotal, :shipping_total, :user_id
  json.url order_url(order, format: :json)
end
