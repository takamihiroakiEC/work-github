class Public::HomesController < ApplicationController

  def top
     @items = Item.page(params[:page])

  end
end
