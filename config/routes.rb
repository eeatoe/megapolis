Rails.application.routes.draw do
  root "products#index"

  resources :products, only: [:index, :show]
  resources :categories, param: :slug, only: [:index, :show]

  # Корзина (доступна и для авторизованных пользователей и для гостей)
  resource :cart, only: [:show] do
    post "add/:product_id", to: "carts#add_item", as: "add"
    delete "remove/:product_id", to: "carts#remove_item", as: "remove"
  end

  # Маршруты для пользователей (регистрация, вход, профиль)
  scope module: "user" do
    resource :profile, only: [:show, :update, :destroy]
    resource :registration, only: [:create]
    resource :session, only: [:create, :destroy]
    get "/login", to: "sessions#new", as: "login"
    
    resource :password, only: [] do
      collection do
        post :reset
        post :update
      end
    end
  end

  # Форма оформления заказа
  resources :orders, only: [:new, :create, :show] 
  get "/checkout", to: "orders#new"

  # Админпанель
  namespace :admin do
    root to: "products#index"
    resources :products
    resources :categories
    resources :orders, only: [:index, :show, :update]
  end

  # Поиск по разным сущностям (товары, бренды, категории)
  get "/search", to: "search#index"


  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
