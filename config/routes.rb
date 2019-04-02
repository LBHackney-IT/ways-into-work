WaysIntoWork::Application.routes.draw do
  devise_for :user_logins

  root to: 'application#index'

  get 'hackney_works', to: redirect('/')

  get 'apprenticeships' => 'static#apprenticeships'
  get 'hackney100' => 'static#hackney100'
  get 'support' => 'static#support'
  get 'employers' => 'static#employers'
  get 'unsubscribed' => 'static#unsubscribed'

  get 'privacy-policy' => 'static#privacy_policy'

  get 'outside-hackney' => 'static#outside_hackney'
  get 'client/referrers/outside-hackney' => 'static#referrer_outside_hackney', as: 'referrer_outside_hackney'
  get 'just-registered' => 'static#just_registered'

  namespace :advisor do
    resource :restore_client, only: :update
    resource :anonymise_client, only: :update
    resources :clients, except: :edit do
      resources :file_uploads, only: %i[create new destroy]
      resources :meetings
      resources :action_plan_tasks
      resources :contact_notes
      resources :achievements
      #resources :enquiries
      member do
        get 'edit(/:tab)', to: 'clients#edit', as: 'edit'
        #get 'enquiries', to: 'enquiries#for_client'
      end
    end

    resources :my_clients, only: :index
    resources :dashboard, only: :index

    resources :task_titles, only: :index
    resources :advisors
    resources :vacancies
    resources :featured_vacancies, only: %i[update]
    resources :opportunities, only: :new do
      resources :enquiries, only: [:show, :update]
    end
    resources :jobs
    resources :external_apprenticeships
    resources :work_placements
    resources :events, only: [:new, :create, :update, :edit] 
    resources :enquiries, only: [:index, :show]
    get 'clients/:client_id/enquiries', to: 'enquiries#for_client', as: :client_enquiries
  end

  resources :clients, only: %i[new create]
  resources :opportunities, only: [:index, :show]

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
    resources :jobs, only: [:show]
    resources :external_apprenticeships, only: [:show]
    resources :opportunities do
      resources :enquiries, only: [:new, :create]
    end
    get 'enquiry_confirm' => 'enquiry_confirm#show'
  end

  match '/401', to: 'errors#unauthorised', via: :all
  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#error', via: :all
end
