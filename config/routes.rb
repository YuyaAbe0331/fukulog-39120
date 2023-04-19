Rails.application.routes.draw do
  devise_for :users
  root to: "garments#index"
  get 'users', to: 'users#hoge'
  resources :garments, only:  [:index, :new, :create]
end
