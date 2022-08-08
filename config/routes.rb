Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  resources :factories do
    member do
      patch :upgrade_level
    end
  end
end
