Iiirc::Application.routes.draw do
  resources :users
  resources :snippets
  resources :organizations, only: %w(index show)

  get '/signin'                  => redirect('/auth/github'), as: :signin
  get '/signout'                 => 'sessions#destroy',       as: :signout
  get '/auth/:provider/callback' => 'sessions#callback',      as: :callback
  get '/signup'                  => 'users#new',              as: :signup

  root :to => 'top#index'
end
