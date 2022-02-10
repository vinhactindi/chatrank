Rails.application.routes.draw do
  root 'static_pages#home'

  get '/welcome' => 'sessions#new'
  get '/auth/:provider/callback' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resources :servers, only: %i[index create update show] do
    resources :channels, only: %i[index create], controller: 'servers/channels'
    resources :periods, only: :index, controller: 'servers/periods'
    resources :members, only: :index, controller: 'servers/members'
  end

  resources :ranks, only: :index
end
