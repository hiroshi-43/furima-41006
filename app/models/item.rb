class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one :order

  # def sold_out?
  # order.present?
  # end
  # present?はRailsのメソッドで、オブジェクトがnilではない、および空でないことを確認します。
  # そのオブジェクトが存在していればtrue、存在していなければfalseを返します。

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :deli_time
  belongs_to_active_hash :ship_cost

  validates :prefecture_id, :category_id, :condition_id, :ship_cost_id, :deli_time_id, presence: true

  validates :item_name, presence: true, length: { maximum: 40 }
  validates :item_text, presence: true, length: { maximum: 1000 }
  validates :image, presence: true
  validates :price, presence: true,
                    numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, only_integer: true }

  validates :prefecture_id, numericality: { other_than: 0, message: 'must be other than 0' }
  validates :category_id, numericality: { other_than: 0, message: 'must be other than 0' }
  validates :condition_id, numericality: { other_than: 0, message: 'must be other than 0' }
  validates :deli_time_id, numericality: { other_than: 0, message: 'must be other than 0' }
  validates :ship_cost_id, numericality: { other_than: 0, message: 'must be other than 0' }
end
