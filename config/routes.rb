require 'sidekiq/web'

Airaware::Application.routes.draw do
  devise_for :users

  namespace :admin do
    constraints AdminAuthorization do
      mount Sidekiq::Web, :at => '/sidekiq'
    end
  end

  root :to => "pages#home"
  scope "(:locale)", :shallow_path => "(:locale)", :locale => /en|zh/ do

    get '/demo', to: "pages#demo"
    resources :locations do
      resources :readings, :only => [:index]
    end
    resources :readings, :only => [] do
      collection do
        get :us_consulate
      end
    end
    resources :sign_ups, :only => [:create]

  end
  namespace :api do
    namespace :v0 do
      resources :readings, :only => [:create] do
      end
    end
  end
end
