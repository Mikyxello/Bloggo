Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
  get 'blogs/index'

  resources :blogs do
  	resources :posts do
  		resources :comments
  	end
  end

  root 'blogs#index'
end
