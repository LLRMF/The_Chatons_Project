class CheckoutController < ApplicationController
  def create
    @total = params[:total].to_d
    @cart_id = params[:cart_id]
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [
        {
          price_data: {
            currency: 'eur',
            unit_amount: (@total * 100).to_i,
            product_data: {
              name: 'Rails Stripe Checkout'
            }
          },
          quantity: 1
        }
      ],
      metadata: {
        order_id: @order_id,

      },
      mode: 'payment',
      customer_email: current_user.email,
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: checkout_cancel_url
    )
    redirect_to @session.url, allow_other_host: true
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    @user = current_user
    @order = Order.new(user_id: current_user.id)
    @total = current_user.cart.cart_items.sum { |cart_item| cart_item.item.price * cart_item.quantity }

    create_order_items(current_user.cart.cart_items) if @order.save
    clear_user_cart if @payment_intent.status == 'succeeded'
  end

  def cancel
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

  def clear_user_cart
    current_user.cart.cart_items.destroy_all
  end
end