Rails.application.routes.draw do

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
             controllers: {omniauth_callbacks: "authentications", registrations: "registrations"}

  resources :authentications
  resources :home, :only  => [:index]
  resources :messages,:only  =>[:new, :create]

  root 'home#index'
end
