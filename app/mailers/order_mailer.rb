class OrderMailer < ApplicationMailer
  def order_confirmation(user, order)
    @user = user
    @order = order
    mail(to: @user.email, subject: 'Confirmation de commande')
  end
end
