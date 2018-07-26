Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'users/sessions'
      }

  resources :blogs do
  	resources :posts do
  		resources :comments
  	end
  end

  resources :users

  resources :tags, only: [:index, :show]

  get 'blogs/index'
  root 'blogs#index'
end
