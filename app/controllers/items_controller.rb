class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @items = Item.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user # 作成者を設定
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :item_name,
      :item_text,
      :price,
      :prefecture_id,
      :category_id,
      :condition_id,
      :deli_time_id,
      :ship_cost_id,
      :image
    ).merge(user_id: current_user.id)
  end
end
