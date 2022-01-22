Rails.application.routes.draw do
  root 'static_pages#home'

  get '/welcome' => 'sessions#new'
  get '/auth/:provider/callback' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resources :servers, only: %i[index create show]
end
