class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])

  end


  private

  def order_params
    params.require(:order).permit(:address, :payment_method, :customer_id, :receiver_name, :billing_amount, :postage, :postal_code)
  end
end
