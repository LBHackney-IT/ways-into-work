WaysIntoWork::Application.routes.draw do

  devise_for :user_logins

  root to: 'welcome#show'

  #TODO tidy this crap - make this more restful
  # it's a bit out of place
  get '/confirm_eligibility'  => 'legal_pages#eligibility'

  namespace :advisor do
    resources :cases, only: :index
  end

  namespace :service_manager do
    resources :cases, only: :index
  end

  resources :clients, only: [:new, :create]

  namespace :client do
    resource :personal_traits, only: [:edit, :update]
    resource :employment_status, only: [:edit, :update], controller: 'employment_status'
    resource :dashboard, only: :show
  end

end
