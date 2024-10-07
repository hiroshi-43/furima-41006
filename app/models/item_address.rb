class ItemAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :city, :address, :building_name, :phone_num, :prefecture, :user_id, :item_id

  validates :postal_code, :city, :address, :phone_num, :prefecture, presence: true
  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
  validates :phone_num, format: { with: /\A\d{10,11}\z/, message: 'is invalid. Enter 10 or 11 digits without hyphens.' }
  validates :prefecture, numericality: { other_than: 1, message: "can't be blank" }

  def save
    order = Order.create(user_id:, item_id:)
    Residence.create(
      postal_code:,
      city:,
      address:,
      building_name:,
      phone_num:,
      prefecture_id: prefecture,
      order_id: order.id
    )
  end
end
