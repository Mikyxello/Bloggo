Rails.application.routes.draw do
  mount Notifications::Engine => "/notifications"
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        omniauth_callbacks: "users/omniauth_callbacks",
        registrations: "users/registrations"
  }

  resources :users

  resources :tags, only: [:index, :show, :destroy]

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
  get 'blogs/:id/reacted_view' => "blogs#reacted_view", :as => :reacted_view
  get 'blogs/:id/followed', to: 'blogs#follow', :as => :follow
  get 'blogs/:id/unfollowed', to: 'blogs#unfollow', :as => :unfollow
  get 'blogs/:id/change_suspended', to:'blogs#change_suspended', :as => :change_suspended
  get 'blogs/:id/favourite', to: 'blogs#favourite', :as => :favourite
  get 'blogs/:id/unfavourite', to:'blogs#unfavourite', :as => :unfavourite
  get 'blogs/:blog_id/posts/:id/favourite', to: 'posts#favourite', :as => :favourite_post
  get 'blogs/:blog_id/posts/:id/unfavourite', to:'posts#unfavourite', :as => :unfavourite_post
  get 'users/upgrade', to: 'users#upgrade', :as => :upgrade
  post 'blogs/:id/add_editors', to: 'blogs#add_editors', :as => :add_editor
  post 'blogs/:id/remove_editors', to: 'blogs#remove_editors', :as => :remove_editor
  get 'admin_panel/index'
  get 'users/:id/change_status', to:'users#change_status', :as => :change_status

  match '*path' => 'application#render_404', via: :all
end
