WaysIntoWork::Application.routes.draw do

  devise_for :user_logins

  root to: 'welcome#show'

  get 'hackney_works' => 'hackney_works#show'

  get 'outside_hackney' => 'eligibility#outside_hackney'
  get 'just_registered' => 'just_registered#show'

  namespace :advisor do
    resources :clients do
      resource :assign, only: :update, controller: 'assign_client'
      resources :file_uploads, only: [:create, :new, :destroy]
      resources :meetings
      resources :action_plan_tasks
      resources :contact_notes, only: [:create, :new, :index]
    end

    resources :my_clients, only: :index
  end

  namespace :service_manager do
    resources :clients, only: [:index, :show] do
    end
  end

  resources :clients, only: [:new, :create] do
  end

  resources :hubs, only: :index


  namespace :client do
    get 'next_steps' => 'next_steps#show'
    resources :file_uploads, only: [:create, :new, :destroy]
    resource :password, only: [:edit]
    resource :profile, only: [:show]
    resource :personal_traits, only: [:edit, :update]
    resource :objectives, only: [:edit, :update]
    resource :education, only: [:edit, :update], controller: 'education'
    resource :employment_status, only: [:edit, :update], controller: 'employment_status'
    resource :additional_information, only: [:edit, :update], controller: 'additional_information'
    resource :dashboard, only: :show
  end

end
