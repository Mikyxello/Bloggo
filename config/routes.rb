Rails.application.routes.draw do
  mount Notifications::Engine => "/notifications"
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        omniauth_callbacks: "users/omniauth_callbacks",
        registrations: "users/registrations"
  }

  resources :users

  resources :search

  resources :tags, only: [:index, :show, :destroy]

  resources :blogs do
  	resources :posts do
  		resources :comments

  collection do
    get 'search'
  end
      member do
        put 'like', to: 'posts#upvote'
        put 'dislike', to: 'posts#downvote'
        get 'favourite', to: 'posts#favourite'
        get 'unfavourite', to:'posts#unfavourite'
      end
  	end
  end

  root 'home#index'
  get 'blogs/index'
  get 'search/index'
  
  get 'blogs/:id/visited_view' => "blogs#visited_view", :as => :visited_view
  get 'blogs/:id/recent_view' => "blogs#recent_view", :as => :recent_view
  get 'blogs/:id/reacted_view' => "blogs#reacted_view", :as => :reacted_view
  get 'blogs/:id/followed', to: 'blogs#follow', :as => :follow
  get 'blogs/:id/unfollowed', to: 'blogs#unfollow', :as => :unfollow
  get 'blogs/:id/change_suspended', to:'blogs#change_suspended', :as => :change_suspended
  get 'blogs/:id/favourite', to: 'blogs#favourite', :as => :favourite
  get 'blogs/:id/unfavourite', to:'blogs#unfavourite', :as => :unfavourite
  get 'users/upgrade/:id', to: 'users#upgrade', :as => :upgrade
  get 'blogs/:id/editors', to: 'blogs#editors', :as => :editors
  post 'blogs/:id/add_editors', to: 'blogs#add_editors', :as => :add_editor
  get 'blogs/:id/remove_editors/:user_id', to: 'blogs#remove_editors', :as => :remove_editor
  get 'admin_panel/index'
  get 'users/:id/change_status', to:'users#change_status', :as => :change_status
  get 'users/:id/all', to: 'users#all', :as => :see_all

  match '*path' => 'application#render_404', via: :all
end
