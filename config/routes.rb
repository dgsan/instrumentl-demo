Rails.application.routes.draw do
  resources :grants
  resources :tax_entities
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static#index'
end
