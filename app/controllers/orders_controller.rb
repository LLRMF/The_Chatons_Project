class OrdersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @orders = current_user.orders if user_signed_in?
  end

  def show
    if user_signed_in?
      @order = current_user.orders.find_by(id: params[:id])
      if @order.nil?
        @order = current_user.orders.create
      end
      @order_items = @order.order_items
      @total_amount = calculate_total_amount(@order_items)
    else
      redirect_to root_path
    end
  end
  
  def new
    @order = current_user.orders.build # Crée une nouvelle commande pour l'utilisateur actuel
    create_order_from_cart_items if current_user.cart.cart_items.present? # Crée des order_items s'il y a des cart_items
    redirect_to @order, notice: 'La commande a été créée avec succès.' # Redirige vers la commande nouvellement créée
  end

  def create
    if current_user.cart.cart_items.present?
      @order = current_user.orders.build
      if @order.save
        create_order_items(current_user.cart.cart_items)

        OrderMailer.order_confirmation(current_user, @order).deliver_now

        redirect_to @order, notice: 'La commande a été créée avec succès.'
      else
        render :new
      end
    else
      redirect_to root_path, notice: 'Le panier est vide.'
    end
  end

  private

  def create_order_items(cart_items)
    cart_items.each do |cart_item|
      order_item = @order.order_items.build(
        item_id: cart_item.item_id,
        quantity: cart_item.quantity
      )
      order_item.save
    end
  end

  
  def create_order_from_cart_items
    return unless @order.save # Vérifie si l'ordre a été sauvegardé avec succès
    create_order_items(current_user.cart.cart_items) # Crée les order_items
    clear_user_cart # Vide le panier
  end
  
  def calculate_total_amount(order_items)
    order_items.sum { |order_item| order_item.item.price * order_item.quantity }
  end
end
