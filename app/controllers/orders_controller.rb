class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_if_item_sold_or_owned, only: [:index, :create]

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @item = Item.find(params[:item_id])
    @order = ItemAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    @order = ItemAddress.new(order_params.merge(user_id: current_user.id, item_id: @item.id))

    if @order.valid?
      pay_item
      @order.save
      redirect_to root_path, notice: 'Order was successfully created.'
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
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
      :phone_num
    ).merge(token: params[:token])
  end

  def redirect_if_item_sold_or_owned
    @item = Item.find(params[:item_id])
    # 出品者である場合、または売却済みの場合にトップページにリダイレクト
    if @item.user_id == current_user.id || @item.sold_out? # rubocop:disable Style/GuardClause
      redirect_to root_path, notice: 'この商品にはアクセスできません'
    end
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] # 自身のPAY.JPテスト秘密鍵を記述
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段を直接取得
      card: order_params[:token], # カードトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end
