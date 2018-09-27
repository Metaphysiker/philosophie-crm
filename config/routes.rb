Rails.application.routes.draw do
  resources :institutions
  resources :tasks
  resources :tag_lists
  resources :tags
  devise_for :users
  resources :notes
  resources :people

  get '/users/:id', to: 'users#show', as: 'user'

  root 'static_pages#main'
  get '/search', to: 'static_pages#search', as: 'search'
  get '/activities', to: 'static_pages#activities', as: 'activities'

  get '/upload_page', to: 'import#upload_page', as: 'upload_page'
  post '/import_people', to: 'import#people', as: 'import_people'

  #search
  #get '/main_search_form', to: 'search#main_search', as: 'main_search_form'
  get '/main_search_form', to: 'search#main_search', as: 'main_search_form'
  get '/people_search_form', to: 'people#people_search', as: 'people_search_form'
  get '/institutions_search_form', to: 'institutions#institutions_search', as: 'institutions_search_form'

  #get 'static_pages/welcome'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
