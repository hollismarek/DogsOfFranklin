Rails.application.routes.draw do
  resources :links
  get 'errors/file_not_found'

  get 'errors/unprocessable'

  get 'errors/internal_server_error'

  resources :news
  #resources :photos
  resources :bios
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index', as: 'home_index'
  get 'home_about', to: 'home#about'
  get 'home_gallery', to: 'home#gallery'
  get 'contacts', to: 'contact#new'
  post 'contacts', to: 'contact#create'
  get 'home_links', to: 'home#links'
  get 'photo_random', to: 'photos#show_random'

  get 'signup', to: 'users#new'
  resources :users

  get 'login', to: 'sessions#new'

  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  match '/404', to: 'errors#file_not_found', via: :all
  match '/422', to: 'errors#unprocessable', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all
end
