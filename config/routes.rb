Rails.application.routes.draw do
  get 'blogs/index'
 
  resources :blogs do
  	resources :posts
  end

  resources :posts do
  	resources :comments
  end
 
  root 'blogs#index'
end