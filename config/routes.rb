WaysIntoWork::Application.routes.draw do
  devise_for :user_logins

  root to: 'welcome#show'

  get 'hackney_works' => 'hackney_works#show'

  get 'outside_hackney' => 'eligibility#outside_hackney'
  get 'just_registered' => 'just_registered#show'

  namespace :advisor do
    resources :clients do
      resources :file_uploads, only: %i[create new destroy]
      resources :meetings
      resources :action_plan_tasks
      resources :contact_notes, only: %i[create new index]
    end

    resources :my_clients, only: :index
  end

  resources :clients, only: %i[new create]

  resources :hubs, only: :index

  namespace :client do
    get 'next_steps' => 'next_steps#show'
    resources :file_uploads, only: %i[create new destroy]
    resource :password, only: [:edit]
    resource :profile, only: [:show]
    resource :personal_traits, only: %i[edit update]
    resource :objectives, only: %i[edit update]
    resource :education, only: %i[edit update], controller: 'education'
    resource :employment_status, only: %i[edit update], controller: 'employment_status'
    resource :additional_information, only: %i[edit update], controller: 'additional_information'
    resource :dashboard, only: :show
  end
end
