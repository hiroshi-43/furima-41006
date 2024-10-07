class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_item, only: [:edit, :update, :show, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]

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

  def purchase
    # 購入画面に関連するロジックをここに追加します
  end

  def show
    @user = @item.user # itemがuserに属している場合
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to @item
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to root_path
  end

  private

  def find_item
    @item = Item.find(params[:id])
  end

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

  def authorize_user
    unless @item.user == current_user # rubocop:disable Style/GuardClause
      redirect_to root_path, alert: 'You are not authorized to edit this item.'
    end
  end
end
