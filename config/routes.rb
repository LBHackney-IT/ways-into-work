WaysIntoWork::Application.routes.draw do

  devise_for :user_logins

  root to: 'welcome#show'

  get '/confirm_eligibility'  => 'legal_pages#eligibility'

  namespace :advisor do
    resources :cases, only: :index
  end

  namespace :service_manager do
    resources :cases, only: :index
  end

  resources :clients, only: [:new, :create]
  namespace :clients do
    resource :dashboard, only: :show
  end

end
