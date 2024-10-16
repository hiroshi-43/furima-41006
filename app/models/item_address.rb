class ItemAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :city, :address, :building_name, :phone_num, :prefecture_id, :user_id, :item_id, :token

  validates :postal_code, :city, :address, :phone_num, :prefecture_id, :user_id, :item_id, :token, presence: true
  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
  validates :phone_num, format: { with: /\A\d{10,11}\z/, message: 'is invalid. Enter 10 or 11 digits without hyphens.' }
  validates :prefecture_id, numericality: { other_than: 0, message: 'must be other than 0' }

  def save
    return false unless valid?

    order = Order.create(user_id:, item_id:)

    return unless order.persisted?

    Residence.create(
      postal_code:,
      prefecture_id:,
      city:,
      address:,
      building_name:,
      phone_num:,
      order_id: order.id # 書き方の違いについて調べる
    )
  end
end
