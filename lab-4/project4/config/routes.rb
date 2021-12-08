Rails.application.routes.draw do
  
  resources :recommendations, path: "recommendations/:operating"
  # evaluations
  get 'evaluations/:id/add', to: 'evaluations#add', as: :add_evaluation
  get 'evaluations/edit', to: 'evaluations#edit', as: :edit_evaluation
  delete 'evaluations/delete', to: 'evaluations#delete', as: :delete_evaluation
  get 'evaluations/:id', to: 'evaluations#index', as: :index_evaluation
  get 'evaluations/show' , to: 'evaluations#show', as: :show_evaluation
  # users routes
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  get '/users', to: 'admin_controls#show_users'
  delete '/users/:id', to: 'admin_controls#delete_user', as: :admin_delete
  post '/users/:id', to: 'admin_controls#activate_user', as: :admin_verify
  # semester routes
  get '/semesters', to: 'admin_controls#show_semesters'
  get '/semesters/new', to: 'admin_controls#new_semester'
  get '/semesters/:id/edit', to: 'admin_controls#edit_semester', as: :edit_semester
  patch '/semesters/:id', to: 'admin_controls#update_semester', as: :update_semester
  post '/semesters', to: 'admin_controls#create_semester'
  delete '/semesters/:id', to: 'admin_controls#delete_semester', as: :delete_semester
  # scraper routes
  get '/scraper', to: 'scraper#index'
  post '/scraper', to: 'scraper#scrape'
  post '/scraper/load',to: 'scraper#load', as: :scrape_load
  get '/scraper/loading/:code',to: 'scraper#load_loading_screen', as: :scrape_loading
  # planner routes
  get '/planner' ,to: 'user_panel#planner'
  get 'planner/:subject', to: 'user_panel#planner'
  put '/planner/:subject' ,to:'user_panel#add', as: :add_course
  delete '/planner/:subject' ,to:'user_panel#drop', as: :drop_course
  # courses/sections/subjects routes
  get '/courses', to: 'subjects#subjects'
  get '/courses/semester', to: 'subjects#show_semester', as: :show_semester
  get '/courses/changeposition/', to: 'subjects#change_position', as: :change_position
  get '/courses/changeposition/apply', to: 'subjects#apply_change_position', as: :apply_position
  # application
  get '/application/show/' , to: 'student_application#application' , as: :show_application
  get '/application/:subject(/:application)' , to: 'student_application#edit' , as: :edit_appliction
  post '/application/add' , to: 'student_application#add' , as: :add_appliction
  delete '/application/:application' , to: 'student_application#destory' , as: :drop_appliction
  get "/admin/application", to: 'admin_application#show'
  get "/admin/application/:application/:subject", to: 'admin_application#assign' , as: :assign_application
  delete "/admin/application/:application", to: 'admin_application#reject' , as: :reject_application
  
  # recommendation
  get "/admin/recommandation", to: "admin_recommendation#show_recommendation" , as: :show_recommendation
  put "/admin/recommandation/assign",  to:  "admin_recommendation#assigned_recommendation" , as: :assign_recommendation
  delete "/admin/recommandation/reject", to: "admin_recommendation#reject_recommendation",  as: :reject_recommendation
  # general routes
  get '/welcome', to: 'general_pages#welcome'
  root to: 'general_pages#home'

end