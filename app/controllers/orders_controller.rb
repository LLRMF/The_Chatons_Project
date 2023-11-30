class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find(params[:id])
    @total = calculate_total_amount(@order.order_items)
    
    # Assurez-vous que l'utilisateur possède cette commande
    unless current_user.orders.include?(@order)
      flash[:alert] = "Vous n'avez pas accès à cette commande."
    end
  end

  private

  def calculate_total_amount(order_items)
    total_amount = 0
    order_items.each do |order_item|
      total_amount += order_item.item.price * order_item.quantity
    end
    total_amount
  end
end
