require 'sidekiq/web'

Airaware::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}, :skip => 'registration'

  namespace :admin do
    constraints AdminAuthorization do
      mount Sidekiq::Web, :at => '/sidekiq'
    end
  end

  root :to => "pages#home"
  scope "(:locale)", :shallow_path => "(:locale)", :locale => /en|zh/ do

    get '/demo', to: "pages#demo"
    resources :locations do
      resources :readings, :only => [:index] do
        collection do
          get :latest
        end
      end
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
