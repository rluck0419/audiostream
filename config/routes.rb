Rails.application.routes.draw do
  resources :reverbs
  resources :users
  resources :instruments
  resources :scales
  resources :notes
  root 'notes#index', as: 'root'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
