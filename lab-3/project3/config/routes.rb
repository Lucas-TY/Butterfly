Rails.application.routes.draw do
  devise_for :users
  get '/users', to: 'admin_controls#show_users'
  get '/courses', to: 'subjects#subjects'
  get '/welcome', to: 'general_pages#welcome'
  root to: 'general_pages#home'
end
