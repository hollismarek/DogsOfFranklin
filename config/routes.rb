Rails.application.routes.draw do
  resources :images
  resources :bios
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index', as: 'home_index'
  get 'home_about', to: 'home#about'
  get 'home_gallery', to: 'home#gallery'
  get 'home_contact', to: 'home#contact'
  get 'home_links', to: 'home#links'

  get 'signup', to: 'users#new'
  resources :users

  get 'login', to: 'sessions#new'

  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

end
