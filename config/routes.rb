Rails.application.routes.draw do

  # the page root
  root 'users#edit'

  # routes for Devise and Omniauth
  devise_for :users

  # routes for Active Admin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)


  # routes for locale change
  get 'sessions/:locale', to: "sessions#switch", as: :sessions

  # routes for Users
  resources :users

  # route for User Sign Out
  devise_scope :user do
    get 'sign_out', to: 'devise/sessions#destroy', as: :signout
  end

end
