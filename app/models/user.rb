class User < ApplicationRecord
  has_one :cart  # Un utilisateur a un seul panier
  has_many :orders  # Un utilisateur peut avoir plusieurs commandes
  


     # nécessaire pour active_storage 
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  after_create :welcome_send
  after_create :create_cart

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
  
  def create_cart
    Cart.create(user_id: self.id)
  end

end
