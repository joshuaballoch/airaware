Airaware::Application.routes.draw do
  root :to => "pages#home"

  resources :locations
end
