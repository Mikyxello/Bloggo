Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        omniauth_callbacks: "users/omniauth_callbacks"
      }

  resources :blogs do
  	resources :posts do
  		resources :comments
      member do
        put "like", to: "posts#upvote"
        put "dislike", to: "posts#downvote"
      end
  	end
  end

  resources :users

  resources :tags, only: [:index, :show]

  get 'blogs/index'
  root 'blogs#index'
end
