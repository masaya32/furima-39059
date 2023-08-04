class PurchaseRooms
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :municipalities, :address, :building_name, :phone_number, :token, :user_id, :item_id

  with_options presence: true do 
    validates :user_id
    validates :item_id
    validates :post_code, format: { with: /\A\d{3}[-]\d{4}\z/}
    validates :prefecture_id
    validates :municipalities
    validates :address
    validates :phone_number, format: { with: /\A\d{10,11}\z/ }
    validates :token
  end
  validates :prefecture_id, numericality: {other_than: 1, message: "can't be blank"}

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Shipping.create(post_code: post_code, prefecture_id: prefecture_id, municipalities: municipalities, address: address, building_name: building_name, phone_number: phone_number, purchase_id: purchase.id)
  end
end