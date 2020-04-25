Rails.application.routes.draw do
  # get 'articles/index'
  # post 'orders/create'
  get '/articles', to: 'articles#index'
  root to: 'articles#index'
  # get '/users/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
