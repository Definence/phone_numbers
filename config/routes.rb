Rails.application.routes.draw do
  resources :phone_numbers, only: :create
  resources :users, only: :create
  resource :sessions, only: %i[create destroy]
  post 'phone_numbers/generate', to: 'phone_numbers#generate'
end
