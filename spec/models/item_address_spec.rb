require 'rails_helper'

RSpec.describe ItemAddress, type: :model do
  before do
    @user = FactoryBot.create(:user) # DBにユーザーを生成
    @item = FactoryBot.create(:item, user: @user) # DBに商品を生成し、ユーザーに関連付け
    @item_address = FactoryBot.build(:item_address, user_id: @user.id, item_id: @item.id)
  end

  describe '配送先の住所情報の保存' do
    context '配送先の住所情報が保存できる場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@item_address).to be_valid
      end

      it '建物名が空でも保存できること' do
        @item_address.building_name = ''
        expect(@item_address).to be_valid
      end
    end

    context '配送先の住所情報が保存できない場合' do
      it 'postal_codeが空では保存できないこと' do
        @item_address.postal_code = ''
        @item_address.valid?
        expect(@item_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeがフォーマット違いでは保存できないこと' do
        @item_address.postal_code = '1234567'
        @item_address.valid?
        expect(@item_address.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end

      it 'prefecture_idが0では保存できないこと' do
        @item_address.prefecture_id = 0
        @item_address.valid?
        expect(@item_address.errors.full_messages).to include('Prefecture must be other than 0')
      end

      it 'phone_numが空では保存できないこと' do
        @item_address.phone_num = ''
        @item_address.valid?
        expect(@item_address.errors.full_messages).to include("Phone num can't be blank")
      end

      it 'phone_numが9桁以下では保存できないこと' do
        @item_address.phone_num = '123456789'
        @item_address.valid?
        expect(@item_address.errors.full_messages).to include('Phone num is invalid. Enter 10 or 11 digits without hyphens.')
      end

      it 'phone_numが12桁以上では保存できないこと' do
        @item_address.phone_num = '123456789012'
        @item_address.valid?
        expect(@item_address.errors.full_messages).to include('Phone num is invalid. Enter 10 or 11 digits without hyphens.')
      end

      it 'phone_numがフォーマット違いでは保存できないこと' do
        @item_address.phone_num = '090-1234-5678'
        @item_address.valid?
        expect(@item_address.errors.full_messages).to include('Phone num is invalid. Enter 10 or 11 digits without hyphens.')
      end

      it 'cityが空では保存できないこと' do
        @item_address.city = ''
        @item_address.valid?
        expect(@item_address.errors.full_messages).to include("City can't be blank")
      end

      it 'addressが空では保存できないこと' do
        @item_address.address = ''
        @item_address.valid?
        expect(@item_address.errors.full_messages).to include("Address can't be blank")
      end

      it 'building_nameが空でも保存できること' do
        @item_address.building_name = ''
        @item_address.valid?
        expect(@item_address.errors.full_messages).to be_empty
      end

      it 'tokenが空では保存できないこと' do
        @item_address.token = ''
        @item_address.valid?
        expect(@item_address.errors.full_messages).to include("Token can't be blank")
      end

      it 'user_idが空では保存できないこと' do
        @item_address.user_id = nil
        @item_address.valid?
        expect(@item_address.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空では保存できないこと' do
        @item_address.item_id = nil
        @item_address.valid?
        expect(@item_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end

# bundle exec rspec spec/models/item_address_spec.rb
