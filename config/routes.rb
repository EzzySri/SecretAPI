Rails.application.routes.draw do
  root 'welcome#index'
  resources :secrets, defaults: {format: :json}
  post 'users' => 'users#create', defaults: {format: :json}
  post 'token' => 'users#authentication_token', defaults: {format: :json}
end
