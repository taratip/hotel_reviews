Rails.application.routes.draw do
  root 'hotels#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :hotels

  resources :hotels, only: [] do
    resources :reviews, only: [:create]
  end

  namespace :admin do
    resources :users, only: [:index, :destroy]
  end

  resources :reviews, only: [:edit, :update, :destroy] do
    member do
      post 'upvote'
      post 'downvote'
      post 'deletevote'
    end
  end

  namespace :api do
    namespace :v1 do
      resources :reviews, only: [:index] do
        member do
          post 'upvote'
          post 'downvote'
          post 'deletevote'
        end
      end
    end
  end
end
