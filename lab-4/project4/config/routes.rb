Rails.application.routes.draw do
  # users routes
  devise_for :users
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
  get '/scraper' ,to: 'scraper#index' 
  post '/scraper/scrapeSU21' ,to: 'scraper#scrape_SU21', as: :scrape_get_SU21
  post '/scraper/scrapeAU21' ,to: 'scraper#scrape_AU21', as: :scrape_get_AU21
  post '/scraper/scrapeSP22' ,to: 'scraper#scrape_SP22', as: :scrape_get_SP22
  post '/scraper/load',to: 'scraper#load', as: :scrape_load
  # planner routes
  get '/planner' ,to: 'user_panel#planner' 
  put '/planner/:subject' ,to:'user_panel#add' ,as: :add_course
  delete '/planner/:subject' ,to:'user_panel#drop' ,as: :drop_course
  # courses/sections routes
  get '/courses', to: 'subjects#subjects'
  # general routes
  get '/welcome', to: 'general_pages#welcome'
  root to: 'general_pages#home'
end
