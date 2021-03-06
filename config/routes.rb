Rails.application.routes.draw do
  # get 'articles/index'
  # post '/articles', to: 'articles#create'
  # get '/articles', to: 'articles#index'
  # get '/articles/new', to: 'articles#new', as: :new_article
  # get '/articles/:id', to: 'articles#show', as: :article
  # get '/articles/:id/edit', to: 'articles#edit', as: :edit_article
  # patch '/articles/:id', to: 'articles#update'
  # delete '/articles/:id', to: 'articles#destroy'

  root to: 'articles#index'

  resources :articles do
    resources :comments, shallow: true #only: [:new, :create, :index]
  end
  #resources :comments, only: [:edit, :update, :destroy, :show]
  get 'users/signup', to: 'users#new'
  resources :users, except: :new

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
