class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_if_item_sold_or_owned, only: [:index, :create]

  def index
    @item = Item.find(params[:item_id])
    @order = ItemAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    @order = ItemAddress.new(order_params.merge(user_id: current_user.id, item_id: @item.id))

    if @order.save
      redirect_to root_path, notice: 'Order was successfully created.'
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:item_address).permit(
      :postal_code,
      :prefecture_id,
      :city, :address,
      :building_name,
      :phone_num,
      :user_id,
      :item_id
    )
  end

  def redirect_if_item_sold_or_owned
    @item = Item.find(params[:item_id])
    # 出品者である場合、または売却済みの場合にトップページにリダイレクト
    return unless @item.user_id == current_user.id || @item.sold_out?

    redirect_to root_path, notice: 'この商品にはアクセスできません'
  end
end
