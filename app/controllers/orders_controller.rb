class OrdersController < ApplicationController
  before_action :set_order, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  layout 'label_layout', :only => [:label]

  def label
    @orders = current_user.orders.find(params[:order_ids])
  end
 
  def mailing
     @mailing = current_user.orders.find_by_sql(
       ["select shipping_name, paypal_email, shipping_address3, shipping_address4, shipping_address5, sum(order_items.quantity) quantity 
       from orders 
       join order_items on orders.id = order_items.order_id 
       where order_items.user_id = ? 
       group by orders.paypal_email, orders.shipping_name, orders.shipping_address5, orders.shipping_address4, orders.shipping_address3",current_user.id])
  end
 
  def index
    @orders = current_user.orders.order("id DESC").all
  end

  def new
    @order = current_user.orders.build
  end

  def edit
  end

  def create

    @order = current_user.orders.build(order_params)

    respond_to do |format|
      if params[:paypal_button] || !@order.save
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      else
        format.html { redirect_to orders_path, notice: 'Order was successfully created.' }
        format.json { render :index, status: :created, location: @order }
      end
    end
  end

  def update

    respond_to do |format|
      if current_user.order.update(order_params)
        format.html { redirect_to orders_path, notice: 'Order was successfully updated.' }
        format.json { render :index, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = current_user.orders.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(
        :transaction_id, 
        :paypal_id, 
        :paypal_email, 
        :date_received, 
        :shipping_name, 
        :shipping_address1, 
        :shipping_address2, 
        :shipping_address3, 
        :shipping_address4, 
        :shipping_address5, 
        :payment_total, 
        :payment_subtotal, 
        :shipping_total, 
        :user_id, 
        order_items_attributes: [:id, :description, :item_number, :unit_price, :quantity, :order_id, :user_id] )
    end
end