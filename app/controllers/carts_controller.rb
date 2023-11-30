class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = current_user.cart
    if @cart
      @cart_items = CartItem.where(cart_id: @cart.id)
      @total_amount = calculate_total_amount(@cart_items)
    else
      flash[:alert] = "Vous n'avez pas de panier. Veuillez ajouter des articles."
      redirect_to root_path
    end
  end

  def remove_item
    @item = Item.find(params[:item_id])
    @cart = current_user.cart
    if @cart
      @cart_item = @cart.cart_items.find_by(item_id: @item.id)
      if @cart_item
        @cart_item.destroy
        redirect_to cart_path, notice: 'Article retiré du panier!'
      else
        redirect_to cart_path, notice: "Cet article n'est pas dans votre panier."
      end
    else
      flash[:alert] = "Vous n'avez pas de panier. Veuillez créer un panier d'abord."
      redirect_to root_path
    end
  end

  private

  def create_cart_if_not_exists
    @cart = current_user.cart || Cart.create(user: current_user)
  end

  
  def calculate_total_amount(cart_items)
    cart_items.sum { |cart_item| cart_item.item.price * cart_item.quantity }
  end
end