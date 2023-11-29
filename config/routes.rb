Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "static_pages#home"
  devise_for :users
  resources :users
  
  # Static pages
  get "about", to: "static_pages#about"
  get "contact", to: "static_pages#contact"
  
  resources :items do
    post 'add_to_cart', on: :member
  end

  resources :carts do
    delete 'remove_item/:item_id', to: 'carts#remove_item', on: :member, as: 'remove_item'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  end
end
