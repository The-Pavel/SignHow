Rails.application.routes.draw do
  get 'gifs/index'

  get 'gifs/show'

  get 'gifs/new'

  get 'gifs/create'

  get 'gifs/edit'

  get 'gifs/update'

  get 'gifs/destroy'

  devise_for :users
  resources :gifs
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
