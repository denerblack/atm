Rails.application.routes.draw do
  get 'accounts/show'
  get 'dashboard', to: "dashboard#index"
  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions" }
  resources :accounts
  post "transactions/withdraw", to: "transactions#withdraw"
  post "transactions/deposit", to: "transactions#deposit"
  post "transactions/transfer", to: "transactions#transfer"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
