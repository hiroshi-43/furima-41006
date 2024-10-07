class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname

    with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角（漢字・ひらがな・カタカナ）で入力してください' } do
      validates :last_name
      validates :first_name
    end

    with_options format: { with: /\A[ァ-ヶー]+\z/, message: 'は全角カタカナで入力してください' } do
      validates :last_name_kana
      validates :first_name_kana
    end

    validates :birthday
  end

  with_options format: { with: /\A(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d]+\z/, message: 'には英字と数字の両方を含めて設定してください' } do
    validates :password, on: :create
    validates :password, on: :update, allow_blank: true
  end

  has_many :items
  has_one :order
end
