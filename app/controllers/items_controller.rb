class ItemsController < ApplicationController
  # before_action :authenticate_user!, except: [:index, :show]
  # private

  def index
  end

  def new
    @item = Item.new
  end

  def create
    Item.create(item_params)
    redirect_to '/'
  end
end
