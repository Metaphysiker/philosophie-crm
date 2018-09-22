Rails.application.routes.draw do
  resources :tag_lists
  resources :tags
  devise_for :users
  resources :notes
  resources :people
  root 'static_pages#main'

  get '/people_search_form', to: 'people#people_search', as: 'people_search_form'

  #get 'static_pages/welcome'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
