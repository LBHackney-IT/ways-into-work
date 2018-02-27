WaysIntoWork::Application.routes.draw do
  devise_for :user_logins

  root to: 'hackney_works#show'

  get 'hackney_works' => 'hackney_works#show'

  get 'hackney_apprenticeships' => 'hackney_apprenticeships#show'
  get 'hackney100' => 'hackney100#show'
  get 'supported_employment' => 'supported_employment#show'

  get 'outside_hackney' => 'eligibility#outside_hackney'
  get 'just_registered' => 'just_registered#show'

  namespace :advisor do
    resource :restore_client, only: :update
    resources :clients, except: :edit do
      resources :file_uploads, only: %i[create new destroy]
      resources :meetings
      resources :action_plan_tasks
      resources :contact_notes, only: %i[create new index]
      resources :achievements
      member do
        get 'edit(/:tab)', to: 'clients#edit', as: 'edit'
      end
    end

    resources :my_clients, only: :index
    resources :dashboard, only: :index

    resources :task_titles, only: :index
    resources :advisors
    resources :vacancies
  end

  resources :clients, only: %i[new create]

  resources :hubs, only: :index

  namespace :client do
    get 'next_steps' => 'next_steps#show'
    resource :referrers, only: %i[new create]
    resources :file_uploads, only: %i[create new destroy]
    resource :password, only: [:edit]
    resource :profile, only: [:show]
    resources :action_plan_tasks, only: [:show]
    resource :personal_traits, only: %i[edit update]
    resource :objectives, only: %i[edit update]
    resource :education, only: %i[edit update], controller: 'education'
    resource :employment_status, only: %i[edit update], controller: 'employment_status'
    resource :additional_information, only: %i[edit update], controller: 'additional_information'
    resource :dashboard, only: :show
  end
end
