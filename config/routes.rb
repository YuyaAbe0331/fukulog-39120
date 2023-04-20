Rails.application.routes.draw do
  devise_for :users
  root to: "garments#index"
  get 'users', to: 'users#redirect_user'
  get 'garments', to: 'garments#redirect_garment'
  resources :garments, only:  [:index, :new, :create, :show] 
end
