Rails.application.routes.draw do

  resources :questions do
    resources :answers, except: [:index, :show]
  end
  resources :users, :sessions

  get 'welcome/index'
  get 'login', to: 'sessions#new', as: :login
  post 'login' => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get 'signup', to: 'users#new', as: :signup
  post 'signup' => 'users#create'
  root 'welcome#index'
end