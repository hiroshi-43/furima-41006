class ItemsController < ApplicationController
  # before_action :authenticate_user!, except: [:index, :show]
  # private

  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user # 作成するアイテムにユーザーを追加
    if @item.save
      redirect_to '/'
    else
      render :new
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
    )
  end
end
