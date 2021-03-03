Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :groups
  resources :front_pages

  resources :groups do
    resources :posts do
      resources :likes, only: [:create, :destroy]
      resources :comments do
        resources :likes, only: [:create, :destroy]
      end
    end

    resources :users
    resources :artist_posts
    resources :users do
      resources :feed_users
      resources :feed_artists
      resources :medias
    end
  end
  resource :profiles
  
  root 'posts#index'

end
