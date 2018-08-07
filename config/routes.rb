Rails.application.routes.draw do
  mount Notifications::Engine => "/notifications"
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        omniauth_callbacks: "users/omniauth_callbacks",
        registrations: "users/registrations"
      }

  resources :blogs do
  	resources :posts do
  		resources :comments
      member do
        put 'like', to: 'posts#upvote'
        put 'dislike', to: 'posts#downvote'
      end
  	end
  end

  root 'home#index'
  get 'blogs/index'
  get 'blogs/:id/visited_view' => "blogs#visited_view", :as => :visited_view
  get 'blogs/:id/recent_view' => "blogs#recent_view", :as => :recent_view
  get 'blogs/:id/followed', to: 'blogs#follow', :as => :follow
  get 'blogs/:id/unfollowed', to: 'blogs#unfollow', :as => :unfollow
  get 'users/upgrade', to: 'users#upgrade', :as => :upgrade
  post 'blogs/:id/add_editors', to: 'blogs#add_editors', :as => :add_editor
  post 'blogs/:id/remove_editors', to: 'blogs#remove_editors', :as => :remove_editor
  get 'admin_panel/index'

  resources :users

  resources :tags, only: [:index, :show, :destroy]

  match '*path' => 'application#render_404', via: :all
end
