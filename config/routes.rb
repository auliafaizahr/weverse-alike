Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resource :profiles

  resources :posts do
    resources :comments do
      resource :likes, only: %i[create destroy]
    end

    resources :likes, only: %i[create destroy]
  end

  root 'posts#index'

end
