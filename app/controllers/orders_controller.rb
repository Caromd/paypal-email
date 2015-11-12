class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /orders
  # GET /orders.json
  def index
    @orders = current_user.orders.all
  end

  def paypal
    @order = current_user.orders.build
#    params[:transaction_id] = '1'
#    params[:paypal_id] = '1'
#    params[:paypal_email] = 'a@a'
#    params[:date_received] = Time.now
#    params[:shipping_name] = 'Name'
#    params[:shipping_address1] = "Add1"
#    params[:shipping_address2] = "Add2"
#    params[:shipping_address3] = "Add3"
#    params[:shipping_address4] = "Add4"
#    params[:payment_total] = 21.50
#    params[:payment_subtotal] = 18.50
#    params[:shipping_total] = 3.00
#    create
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = current_user.orders.build
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
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
      params.require(:order).permit(:transaction_id, :paypal_id, :paypal_email, :date_received, :shipping_name, :shipping_address1, :shipping_address2, :shipping_address3, :shipping_address4, :payment_total, :payment_subtotal, :shipping_total, :user_id)
    end
end
