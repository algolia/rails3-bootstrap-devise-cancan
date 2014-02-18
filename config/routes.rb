Rails3BootstrapDeviseCancan::Application.routes.draw do

  resources :books do
    collection do
      # secured search
      get 'search'
    end
  end

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end