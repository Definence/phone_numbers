Rails.application.routes.draw do
  resources :phone_numbers
  resources :users
  resources :sessions
  post 'phone_numbers/generate', to: 'phone_numbers#generate'
end
