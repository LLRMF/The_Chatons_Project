class User < ApplicationRecord
  has_one :cart  # Un utilisateur a un seul panier
  has_many :orders  # Un utilisateur peut avoir plusieurs commandes
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
