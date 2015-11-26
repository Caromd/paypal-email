class OrderItemsController < ApplicationController
  before_action :set_order_item, only: [:edit, :update, :destroy]

  def index
    @order_items = OrderItem.all
  end

  def summary
#    if (params[:start] != "" && params[:start] != nil)
bom = DateTime.new(2015,11,8)
eom = DateTime.new(2015,11,26)
#      bom = DateTime.new(params["start_date(1i)"].to_i, params["start_date(2i)"].to_i, params["start_date(3i)"].to_i)
#     eom = DateTime.new(params["end_date(1i)"].to_i, params["end_date(2i)"].to_i, params["end_date(3i)"].to_i)
      @orders = current_user.orders.where(:date_received => bom.beginning_of_day..eom.end_of_day).ids
      @order_items = OrderItem.where(:order_id => [31,32,33,34]).group(:description).sum(:quantity)
# TO DO:  1. GET DATE RANGE WORKING
#         2. GET ORDER ID RANGE WORKING
#    else  
#      flash[:alert] = "Please enter month and year to summarise"
#    end
  end

  def new
    @order_item = OrderItem.new
  end

  def edit
  end

  def create
    @order_item = OrderItem.new(order_item_params)

    respond_to do |format|
      if @order_item.save
        format.html { redirect_to @order_item, notice: 'Order item was successfully created.' }
        format.json { render :show, status: :created, location: @order_item }
      else
        format.html { render :new }
        format.json { render json: @order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @order_item.update(order_item_params)
        format.html { redirect_to @order_item, notice: 'Order item was successfully updated.' }
        format.json { render :show, status: :ok, location: @order_item }
      else
        format.html { render :edit }
        format.json { render json: @order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order_item.destroy
    respond_to do |format|
      format.html { redirect_to order_items_url, notice: 'Order item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_item
      @order_item = OrderItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_item_params
      params.require(:order_item).permit(:description, :item_number, :unit_price, :quantity, :order_id)
    end
end
