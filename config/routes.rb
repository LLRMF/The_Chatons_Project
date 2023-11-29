Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "static_pages#home"
  resources :items, only: [:index, :show]
  devise_for :users

  resources :items, only: [:index, :show] do
    member do
      post 'add_to_cart/:item_id', action: :add_to_cart, as: :add_to_cart
    end
  end


  resources :carts, only: [:index, :create, :show] do
    member do
      delete 'remove_item/:item_id', action: :remove_item, as: :remove_item
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  # root "posts#index"

  # Static pages
  get "about", to: "static_pages#about"
  get "contact", to: "static_pages#contact"



  resources :users



  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  end
end
