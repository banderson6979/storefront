Rails.application.routes.draw do
  # Routes for Devise and Omniauth
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  devise_scope :user do
    get 'sign_out', to: 'devise/sessions#destroy', as: :signout
  end
  
  # routes for Active Admin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  # routes for the API's
  namespace :api, defaults: {format: :json} do
    devise_scope :user do
      post   'sign_in'  => 'sessions#create'
      delete 'sign_out' => 'sessions#destroy'
      post   'forgot'   => 'sessions#forgot'
    end
    resources :users
    resources :sessions
  end
  
  # routes for Omniauth
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  
  # routes for locale chage - will be removed
  get '*path', to: redirect("/#{I18n.default_locale}/%{path}"), constraints: lambda { |req| !req.path.starts_with? "/#{I18n.default_locale}/" }
  get '', to: redirect("/#{I18n.default_locale}")

  # the page root
  root 'pages#index'
end
