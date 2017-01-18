Rails.application.routes.draw do
  root 'hotels#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :hotels, only: [:new, :create, :show]
end
