Rails.application.routes.draw do
# 顧客用
# URL /customers/sign_in ...
devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}


namespace :public do
  root to: "homes#top"
  get 'homes/about' => 'homes/about'
  resources :items
  delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
  resources :cart_items



  get 'customers/my_page' => 'customers#show'
  get 'customers/information/edit' => 'customers#edit'
  patch 'customers/information' => 'customers#update'
  get 'customers/confirm' => 'customers#confirm'
  patch 'customers/withdraw' => 'customers#withdraw'

  # get 'cart_items' => 'cart_items#index'
  # post 'cart_items' => 'cart_items#create'
  # patch 'cart_items/:id' => 'cart_items#update'
  # delete 'cart_items/:id' => 'cart_items#destroy'


  get 'orders/new' => 'orders#new'

  post 'orders/confirm' => 'orders#confirm'
  get 'orders/complete' => 'orders#complete'
  get 'orders' => 'orders#index'
  post 'orders' => 'orders#create'

  get 'orders/:id' => 'orders#show', as: 'order'


end

namespace :admin do
    root to: "homes#top"
    # get 'items' => 'items#index'
    # get 'items/new' => 'items#new'
    # post 'items' => 'items#create'
    # get 'items/:id' => 'items#show'
    # get 'items/:id/edit' => 'items#edit'
    # patch 'items/:id' => 'items#update'
    resources :items
    resources :customers
    resources :orders
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
