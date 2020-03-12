Rails.application.routes.draw do
  get 'dashboard', to: "dashboard#index"
  devise_for :users, controllers: { registrations: "users/registrations" }
  resources :accounts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
