Rails.application.routes.draw do

  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :gifs
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/search', to: 'pages#search', as: 'search'
  get '/dashboard/:id' , to: "pages#dashboard", as: 'dashboard'
  post '/gifs/:id' , to: "gifs#favorite", as: 'favorite'
  post '/gifs/unfavorite/:id' , to: "gifs#unfavorite", as: 'unfavorite'
  post '/gifs/upvote/:id' , to: "gifs#upvote", as: 'upvote'
  post '/gifs/downvote/:id' , to: "gifs#downvote", as: 'downvote'
  get '/about', to: 'pages#about', as: 'about'

end
