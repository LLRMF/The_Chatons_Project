class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items
  after_create :order_confirmation
  def order_confirmation
    OrderMailer.order_confirmation(self).deliver_now
  end
end
