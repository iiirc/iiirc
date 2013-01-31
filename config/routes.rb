Rfckun::Application.routes.draw do
  get '/signin'                  => redirect('/auth/github'), as: :signin
  get '/signout'                 => 'sessions#destroy',       as: :signout
  get '/auth/:provider/callback' => 'sessions#callback',      as: :callback

  root :to => 'top#index'
end
