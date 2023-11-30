class OrderMailer < ApplicationMailer
  default from: 'the-chaton-project@hotmail.com'
  def order_confirmation(order)
    @order = order
    @user = @order.user
    #@total_amount = OrdersController.calculate_total_amount(@order.order_items)
    mail(to: @user.email, subject: 'Confirmation de commande')
  end
end
