Rails.application.routes.draw do
  get 'blogs/index'
 
  resources :blogs do
  	resources :posts do
  		resources :comments
  	end
  end
 
  root 'blogs#index'
end