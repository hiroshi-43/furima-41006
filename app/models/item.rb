class Item < ApplicationRecord
  belongs_to :uesr
  belongs_to :prefecture
  belongs_to :category
  belongs_to :condition
  belongs_to :deli_time
  belongs_to :ship_cost

  validates :item_name, presence: true
  validates :item_text, presence: true
  validates :price, presence: true

  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :condition_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :deli_time_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :ship_cost_id, numericality: { other_than: 1, message: "can't be blank" }
end
