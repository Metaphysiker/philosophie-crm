Rails.application.routes.draw do

  resources :addresses
  resources :institutions
  resources :tasks
  resources :tag_lists
  resources :tags
  devise_for :users
  resources :notes
  resources :people

  #users
  get '/users/:id', to: 'users#show', as: 'user'

  #tasks
  get '/check_task/:id', to: 'tasks#check_task', as: 'check_task'

  #static_pages
  root 'static_pages#main'
  get '/search', to: 'static_pages#search', as: 'search'
  get '/activities', to: 'static_pages#activities', as: 'activities'
  get '/team', to: 'static_pages#team', as: 'team'

  #import and upload
  get '/upload_page', to: 'import#upload_page', as: 'upload_page'
  post '/import_people', to: 'import#people', as: 'import_people'
  get '/testing', to: 'import#testing', as: 'testing'

  #search
  #get '/main_search_form', to: 'search#main_search', as: 'main_search_form'
  get '/main_search_form', to: 'search#main_search', as: 'main_search_form'
  get '/people_search_form', to: 'people#people_search', as: 'people_search_form'
  get '/institutions_search_form', to: 'institutions#institutions_search', as: 'institutions_search_form'

  #get 'static_pages/welcome'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
