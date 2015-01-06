Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }

  root 'pages#index'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  devise_scope :user do
    get 'sign_out', to: 'devise/sessions#destroy', as: :signout
  end

  get '*path', to: redirect("/#{I18n.default_locale}/%{path}"), constraints: lambda { |req| !req.path.starts_with? "/#{I18n.default_locale}/" }
  get '', to: redirect("/#{I18n.default_locale}")

end

Starterkitrails::Application.routes.draw do


  namespace :api, defaults: {format: :json} do
    devise_scope :user do
      post   'sign_in'  => 'sessions#create'
      delete 'sign_out' => 'sessions#destroy'
      post   'forgot'   => 'sessions#forgot'
    end

    resources :users
    resources :sessions

  end
end
