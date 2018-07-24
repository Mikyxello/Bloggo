Rails.application.routes.draw do
  get 'welcome/index'
 
  resources :blogs do
  	resources :posts
  end

  resources :posts do
  	resources :comments
  end
 
  root 'welcome#index'
end