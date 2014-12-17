Starterkitrails::Application.routes.draw do

#  devise_for :admin_users, ActiveAdmin::Devise.config
#  ActiveAdmin.routes(self)
#  devise_for :users, controllers: {
#    omniauth_callbacks: "users/omniauth_callbacks"
#  }

  namespace :api, defaults: {format: :json} do
    devise_scope :user do
      post   'sign_in'  => 'sessions#create'
      delete 'sign_out' => 'sessions#destroy'
      post   'forgot'   => 'sessions#forgot'
    end

    resources :users
    resources :sessions
    resources :docs

    resources :categories

    resources :channels
    resources :channelitems

    # API for Sunspot Solr exposure to Channels
    get "channelSearches" => "channel_search#index"

    resources :tags

    resources :creditcards

    resources :favoriteships
    resources :subscriptions
    resources :invoices
    resources :invoiceitems

    resources :slides

    resources :networklogos
  end

  root "pages#index"
end
