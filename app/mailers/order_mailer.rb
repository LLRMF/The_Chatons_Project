class OrderMailer < ApplicationMailer
  def order_confirmation(user, order)
    @user = user
    @order = order
    @total_amount = OrdersController.calculate_total_amount(@order.order_items)
    mail(to: @user.email, subject: 'Confirmation de commande')
  end
end
