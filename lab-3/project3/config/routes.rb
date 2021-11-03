Rails.application.routes.draw do
  devise_for :users
  get '/users', to: 'admin_controls#show_users'
  delete '/users/:id', to: 'admin_controls#delete_user', as: :admin_delete
  post '/users/:id', to: 'admin_controls#activate_user', as: :admin_verify
  get '/scraper' ,to: 'scraper#index' 
  post '/scraper/scrape' ,to: 'scraper#scrape_SU21', as: :scrape_get_SU21
  post '/scraper/scrape' ,to: 'scraper#scrape_AU21', as: :scrape_get_AU21
  post '/scraper/scrape' ,to: 'scraper#scrape_SP21', as: :scrape_get_SP21
  post '/scraper/load',to: 'scraper#load', as: :scrape_load
  get '/planner' ,to: 'user_panel#planner' 
  put '/planner/:subject' ,to:'user_panel#add' ,as: :add_course
  delete '/planner/:subject' ,to:'user_panel#drop' ,as: :drop_course
  get '/courses', to: 'subjects#subjects'
  get '/welcome', to: 'general_pages#welcome'
  root to: 'general_pages#home'
end
