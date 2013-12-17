Iiirc::Application.routes.draw do
  resources :users, except: %w(edit)
  resources :snippets, except: %w(edit update) do
    resources :messages, only: %w(destroy) do
      resources :stars, only: %w(create)
    end
  end
  resources :organizations, only: %w(index show)

  get    '/signin'                  => redirect('/auth/github'), as: :signin
  delete '/signout'                 => 'sessions#destroy',       as: :signout
  get    '/auth/:provider/callback' => 'sessions#callback',      as: :callback
  get    '/signup'                  => 'users#new',              as: :signup
  get    '/transition'              => 'transition#show',        as: :transition
  get    '/image_proxy'             => 'image_proxy#show',       as: :image_proxy
  post   '/snippets/preview'        => 'snippets#preview',       as: :snippet_preview

  scope '/api' do
    resources :snippets, controller: 'api/snippets', only: %w[show]
  end

  root to: 'top#index'
end
