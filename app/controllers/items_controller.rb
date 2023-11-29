class ItemsController < ApplicationController
  
  def index
    @items = Item.all
  end

  def show
    set_item()
  end

  def add_to_cart
    @item = Item.find(params[:id])
    @cart = current_user.cart
  
    if user_signed_in?
      if @cart
        if @cart.cart_items.exists?(item_id: @item.id)
          redirect_to cart_path, notice: 'Cet article est déjà dans votre panier!'
        else
          @cart_item = @cart.cart_items.create(item: @item)
          redirect_to cart_path, notice: 'Article ajouté au panier!'
        end
      else
        flash[:alert] = "Vous n'avez pas de panier. Veuillez créer un panier d'abord."
        redirect_to root_path
      end
    else
      redirect_to new_user_session_path, notice: "Vous devez être connecté pour ajouter des articles à votre panier."
    end
  end
  
  private

  def set_item
    @item = Item.find(params[:id])
  end


  def item_params
    params.require(:item).permit(:title, :description, :price, :image_url)
  end



end
