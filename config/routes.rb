Rfckun::Application.routes.draw do
  get '/auth/:provider/callback' => 'sessions#callback', as: :callback
  get '/signout'                 => 'sessions#destroy',  as: :signout

  root :to => 'top#index'
end
