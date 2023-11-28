class CartsController < ApplicationController
  def index
  end

  def create
    @cart = Cart.create(user_id: current_user.id)
  end

  def show
    if current_user
      @cart = current_user.cart
      @cart_items = @cart.cart_items.includes(:item) if @cart
    else
      redirect_to new_user_session_path, alert: "Vous devez être connecté pour accéder à votre panier."
    end
  end

  def add_item
    @item = Item.find(params[:item_id])
    @cart = current_user.cart || current_user.create_cart
    @cart.cart_items.create(item: @item) unless @cart.items.include?(@item)
    redirect_to cart_path, notice: 'Article ajouté au panier!'
  end

  def remove_item
    @item = Item.find(params[:item_id])
    @cart = current_user.cart
    @cart.cart_items.where(item: @item).destroy_all if @cart
    redirect_to cart_path, notice: 'Article retiré du panier!'
  end
end

