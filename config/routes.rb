Rails.application.routes.draw do
  resources :institutions
  resources :tasks
  resources :tag_lists
  resources :tags
  devise_for :users
  resources :notes
  resources :people
  root 'static_pages#main'

  get 'upload_page', to: 'import#upload_page', as: 'upload_page'
  post '/import_people', to: 'import#people', as: 'import_people'

  get '/people_search_form', to: 'people#people_search', as: 'people_search_form'

  #get 'static_pages/welcome'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
