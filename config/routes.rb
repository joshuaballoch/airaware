Airaware::Application.routes.draw do
  root :to => "pages#home"

  resources :locations

  namespace :api do
    namespace :v0 do
      resources :readings, :only => [:create] do
      end
    end
  end
end
