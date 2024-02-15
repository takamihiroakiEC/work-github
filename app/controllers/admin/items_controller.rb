class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to admin_item_path(@item.id)
  end

  def index
    @items = Item.page(params[:page])
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])

  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])

    if @item.update(item_params)
      redirect_to admin_item_path(@item.id)
    else
      render :edit
    end

  end

  private
  # ストロングパラメータ
  def item_params
    params.require(:item).permit(:name, :image, :introduction, :price)
  end


end
