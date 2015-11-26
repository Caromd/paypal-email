class OrdersController < ApplicationController
  before_action :set_order, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  layout 'label_layout', :only => [:label]

  def label
    @orders = current_user.orders.find(params[:order_ids])
  end
  
  def summary
#    if (params[:start] != "" && params[:start] != nil)
bom = DateTime.new(2015,11,8)
eom = DateTime.new(2015,11,26)
#      bom = DateTime.new(params["start_date(1i)"].to_i, params["start_date(2i)"].to_i, params["start_date(3i)"].to_i)
#     eom = DateTime.new(params["end_date(1i)"].to_i, params["end_date(2i)"].to_i, params["end_date(3i)"].to_i)
      puts bom
      @orders = current_user.orders.find(:all, :conditions => ["date_received >= ? and date_received <= ?", bom, eom])
      # .joins(:order_items)
#      @order_items = OrderItem.sum(:quantity).group(:description)
#      @order_items = OrderItem.joins(Order)
#      .select("order_items.description, SUM(order_items.quantity) as quantity")
#      .group("order_items.description")
#      .order("order_items.description")
# @order_items = current_user.orders.joins(OrderItem).sum('order_items.description/order_items.quantity')
      
#    else  
#      flash[:alert] = "Please enter month and year to summarise"
#    end
  end

  def index
    @orders = current_user.orders.all
  end

  def new
    @order = current_user.orders.build
    @order.order_items.build
  end

  def edit
  end

  def create

    @order = current_user.orders.build(order_params)
    @order.order_items.build

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
#    @order.order_items.build
    respond_to do |format|
      if @order.update(order_params)
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
      @order = Order.find(params[:id])
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
        order_items_attributes: [:id, :description, :item_number, :unit_price, :quantity, :order_id] )
    end
end
