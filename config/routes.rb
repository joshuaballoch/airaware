Airaware::Application.routes.draw do
  root :to => "pages#home"
  get '/demo', to: "locations#show"
  resources :locations do
    resources :readings, :only => [:index]
  end
  resources :readings, :only => [] do
    collection do
      get :us_consulate
    end
  end
  resources :sign_ups, :only => [:create]


  namespace :api do
    namespace :v0 do
      resources :readings, :only => [:create] do
      end
    end
  end
end
