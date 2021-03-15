Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :groups
  resources :front_pages

  resources :groups do
    # get "/join_groups/unique", to: "join_groups#find_username"
    resources :join_groups

    resources :posts do
      resources :likes, only: [:create, :destroy]
      resources :comments do
        resources :likes, only: [:create, :destroy]
      end
    end

    resources :users
    resources :artist_posts
    resources :medias do
      resources :media_likes, only: [:create, :destroy]
      resource :watch_medias, only: [:show]
    end
    resources :users do
      resources :feed_users
      resources :feed_artists
    end
  end
  resource :profiles

  root 'front_pages#index'

end
