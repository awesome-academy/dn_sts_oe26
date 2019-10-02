Rails.application.routes.draw do

  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

    get "/signup", to: "users#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "/confirm_email", to: "users#confirm_email"
    post "/confirm_email", to: "users#check_code"

    resources :users, only: [:new, :create]
    resources :notifications, only: [:new, :create, :destroy]

    mount ActionCable.server => "/cable"
  end
  namespace :admin do
    resources :users
    resources :courses
    resources :notifications, except: :new
    resources :subjects
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
