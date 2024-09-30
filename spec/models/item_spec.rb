require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item, user: @user)
  end

  describe '出品情報登録' do
    it '全ての必須項目が存在すれば出品できる' do
      expect(@item).to be_valid
    end

    # 追加のテストケースがあればここに記述
  end
end

# bundle exec rspec spec/models/item_spec.rb
