require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post :create, order: { date_received: @order.date_received, payment_subtotal: @order.payment_subtotal, payment_total: @order.payment_total, paypal_email: @order.paypal_email, paypal_id: @order.paypal_id, shipping_address1: @order.shipping_address1, shipping_address2: @order.shipping_address2, shipping_address3: @order.shipping_address3, shipping_address4: @order.shipping_address4, shipping_name: @order.shipping_name, shipping_total: @order.shipping_total, transaction_id: @order.transaction_id, user_id: @order.user_id }
    end

    assert_redirected_to order_path(assigns(:order))
  end

  test "should show order" do
    get :show, id: @order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order
    assert_response :success
  end

  test "should update order" do
    patch :update, id: @order, order: { date_received: @order.date_received, payment_subtotal: @order.payment_subtotal, payment_total: @order.payment_total, paypal_email: @order.paypal_email, paypal_id: @order.paypal_id, shipping_address1: @order.shipping_address1, shipping_address2: @order.shipping_address2, shipping_address3: @order.shipping_address3, shipping_address4: @order.shipping_address4, shipping_name: @order.shipping_name, shipping_total: @order.shipping_total, transaction_id: @order.transaction_id, user_id: @order.user_id }
    assert_redirected_to order_path(assigns(:order))
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order
    end

    assert_redirected_to orders_path
  end
end
