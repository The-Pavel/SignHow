Rails.application.routes.draw do

  get '/users/sign_out', to: redirect('/')
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks', sessions: 'users/sessions', registrations: 'users/registrations' }

  ActiveAdmin.routes(self)
  resources :gifs
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/search', to: 'pages#search', as: 'search'
  get '/dashboard/:id' , to: "pages#dashboard", as: 'dashboard'
  post '/gifs/:id/favorite' , to: "gifs#favorite", as: 'favorite'
  post '/gifs/:id/unfavorite' , to: "gifs#unfavorite", as: 'unfavorite'
  post '/gifs/upvote/:id' , to: "gifs#upvote", as: 'upvote'
  post '/gifs/downvote/:id' , to: "gifs#downvote", as: 'downvote'
  get '/about', to: 'pages#about', as: 'about'
  get '/how-it-works', to: 'pages#how_it_works', as: 'how_it_works'
  # get '/gifs/:id/tagged', to: "gifs#tagged", as: :tagged
end
