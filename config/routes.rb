Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index', as: 'home_index'
  get 'home_about', to: 'home#about'
  get 'home_gallery', to: 'home#gallery'
  get 'home_contact', to: 'home#contact'
  get 'home_links', to: 'home#links'
end
