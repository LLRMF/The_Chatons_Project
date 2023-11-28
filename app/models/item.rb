class Item < ApplicationRecord

  validates :title, length: { minimum: 2}
  validates :price, numericality: { greater_than: 0, message: "must be positive"}
  validates :description, length: { in: 20...150}

  has_many :cart_items
  has_many :carts, through: :cart_items

  has_many :order_items
  has_many :orders, through: :order_items
end
