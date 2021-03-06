Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: "users/registrations" }
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

    get "/signup", to: "users#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "/confirm_email", to: "users#confirm_email"
    post "/confirm_email", to: "users#check_code"

    # resources :users, only: [:new, :create]
    resources :notifications, only: [:new, :create, :destroy]

    mount ActionCable.server => "/cable"
  end
  namespace :admin do
    resources :users do
      collection do
        match "search" => "users#search", via: [:get, :post], as: :search
      end
    end
    resources :courses, except: :show do
      collection do
        match "search" => "courses#search", via: [:get, :post], as: :search
      end
    end
    resources :notifications, except: :new
  end
  resources :users, except: [:index, :destroy]
  resources :course_users, only: [ :create, :destroy]
  resources :tasks, only: [:edit, :update , :create, :destroy]
  resources :courses, only: [:index, :show] do
    resources :subjects, only: [:show, :edit, :update]
  end
  resources :user_course_tasks, except: [:index, :show]

  post "/login", to: "sessions#create"
  get "/notfound", to: "courses#notfound"
  delete "/logout", to: "sessions#destroy"
end
