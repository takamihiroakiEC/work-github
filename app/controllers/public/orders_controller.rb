class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :cart_is_exist,only:[:new, :confirm]

  def new
    @order = Order.new
    @address = current_customer.address


  end

  def create
    @order = Order.new(order_params)
    @order.save
    @cart_items = current_customer.cart_items

    @cart_items.each do |cart_item|
     @ordered_item = OrderedItem.new
     @ordered_item.item_id = cart_item.item_id
     @ordered_item.amount = cart_item.amount
     @ordered_item.order_id = @order.id
     @ordered_item.purchase_price = cart_item.item.price
     @ordered_item.save
    end

    @cart_items.destroy_all

    redirect_to public_orders_complete_path


  end

  def index
    @orders = current_customer.orders


  end

  def show
    @order = Order.find(params[:id])

  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:address] == "0"
      @order.address = current_customer.address
      @order.receiver_name = current_customer.last_name + current_customer.first_name
      @order.postal_code = current_customer.postal_code

    elsif params[:order][:address] == "1"



    elsif params[:order][:address] == "2"

    else
      render 'new'
    end

  @cart_items = current_customer.cart_items
  @order.id = current_customer.id

  end

  def complete

  end
# 投稿データのストロングパラメータ
  private

  def order_params
    params.require(:order).permit(:address, :payment_method, :customer_id, :receiver_name, :billing_amount, :postage, :postal_code)
  end

  def cart_is_exist
    cart_item = current_customer.cart_items
    if cart_item.empty?
      redirect_to public_cart_items_path
    end
  end

end
