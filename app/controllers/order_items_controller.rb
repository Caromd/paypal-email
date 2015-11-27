class OrderItemsController < ApplicationController
  before_action :set_order_item, only: [:edit, :update, :destroy]

  def index
    @order_items = OrderItem.all
  end

  def summary
    if params[:start_date].nil?
      flash.now[:alert] = "Please enter start date and end date to summarise"
    else
      bom = DateTime::civil(params[:start_date][:year].to_i, params[:start_date][:month].to_i,params[:start_date][:day].to_i)
      eom = DateTime::civil(params[:end_date][:year].to_i, params[:end_date][:month].to_i,params[:end_date][:day].to_i)
      @orders = current_user.orders.where(:date_received => bom.beginning_of_day..eom.end_of_day).ids
      if @orders.empty?
        flash.now[:alert] = "There are no records for the date range specified"
      end
      @order_items = OrderItem.where(:order_id => @orders).group(:description).sum(:quantity)
    end
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