class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @item = Item.find(params[:item_id])
    @order = ItemAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    Rails.logger.info "Parameters: #{params.inspect}" # デバッグ用ログ出力
    @order = ItemAddress.new(order_params.merge(user_id: current_user.id, item_id: @item.id))

    if @order.save
      redirect_to item_path(@item), notice: 'Order was successfully created.'
    else
      Rails.logger.info "Order errors: #{@order.errors.full_messages}" # エラーメッセージのログ出力
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:item_address).permit(:postal_code, :prefecture_id, :city, :address, :building_name, :phone_num, :user_id,
                                         :item_id)
  end
end
