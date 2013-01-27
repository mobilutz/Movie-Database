Imdb::Application.routes.draw do
  resources :categories


  # resources :ratings

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :sessions
  resources :users

  scope 'api' do
    resources :movies, only: [:index, :create]
  end
  resources :movies, except: [:index, :create] do
    resources :ratings
  end

  root :to => 'main#index'
  # match '*path' => 'main#index'
end
