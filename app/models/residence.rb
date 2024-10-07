class Residence < ApplicationRecord
  belongs_to :order

  validates :postal_code, presence: true
  validates :city, presence: true
  validates :address, presence: true
  validates :building_name, presence: true
  validates :phone_num, presence: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
end
