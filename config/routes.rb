Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :groups
  resources :front_pages
  resources :admins

  resources :groups do
    resource :profiles

    get "join_groups/join_new", to: 'join_groups#join_new'

    resources :join_groups do
      # get :join_new
    end
    resources :posts do
      resources :likes, only: [:create, :destroy]
      resources :comments do
        resources :comment_likes, only: [:create, :destroy]
      end
    end

    resources :users
    resources :artist_posts
    resources :medias do
      resources :likes, only: [:create, :destroy]
      resources :media_likes, only: [:create, :destroy]
      resources :comments do
        resources :comment_likes, only: [:create, :destroy]
      end
    end

    resources :users do
      resources :feed_users
      resources :feed_artists
    end
  end

  root 'front_pages#index'

end