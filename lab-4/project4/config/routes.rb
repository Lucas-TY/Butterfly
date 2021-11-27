Rails.application.routes.draw do
  devise_for :users
  get '/users', to: 'admin_controls#show_users'
  delete '/users/:id', to: 'admin_controls#delete_user', as: :admin_delete
  post '/users/:id', to: 'admin_controls#activate_user', as: :admin_verify
  get '/scraper' ,to: 'scraper#index'
  post '/scraper/scrapeSU21' ,to: 'scraper#scrape_SU21', as: :scrape_get_SU21
  post '/scraper/scrapeAU21' ,to: 'scraper#scrape_AU21', as: :scrape_get_AU21
  post '/scraper/scrapeSP22' ,to: 'scraper#scrape_SP22', as: :scrape_get_SP22
  post '/scraper/load',to: 'scraper#load', as: :scrape_load
  get '/planner' ,to: 'user_panel#planner'
  put '/planner/:subject' ,to:'user_panel#add' ,as: :add_subject
  delete '/planner/:subject' ,to:'user_panel#drop' ,as: :drop_subject
  get '/application' , to: 'student_application#application'
  get '/application/:subject(/:application)' , to: 'student_application#edit' , as: :edit_appliction
  post '/application/add' , to: 'student_application#add' , as: :add_appliction
  delete '/application/:application' , to: 'student_application#destory' , as: :drop_appliction
  get '/courses', to: 'subjects#subjects'
  get '/welcome', to: 'general_pages#welcome'
  get "/admin/application", to: 'admin_application#show'
  get "/admin/application/:application/:subject", to: 'admin_application#assign' , as: :assign_application

  root to: 'general_pages#home'
end
