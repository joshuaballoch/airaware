Airaware::Application.routes.draw do
  root :to => "pages#home"
  get '/demo', to: "locations#show"
  resources :locations do
    resources :readings, :only => [:index]
  end

  namespace :api do
    namespace :v0 do
      resources :readings, :only => [:create] do
      end
    end
  end
end
