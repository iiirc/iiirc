Iiirc::Application.routes.draw do
  resources :users, except: %w(edit)
  resources :snippets do
    resources :messages, only: %w(destroy)
  end
  resources :organizations, only: %w(index show)

  get '/signin'                  => redirect('/auth/github'), as: :signin
  get '/signout'                 => 'sessions#destroy',       as: :signout
  get '/auth/:provider/callback' => 'sessions#callback',      as: :callback
  get '/signup'                  => 'users#new',              as: :signup

  scope '/api' do
    resources :snippets, controller: 'api/snippets', only: %w[show]
  end

  root :to => 'top#index'
end
