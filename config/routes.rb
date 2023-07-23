Rails.application.routes.draw do
  get 'dashboards/show'
  
  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"
  delete "logout", to: "sessions#destroy"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
   root "dashboards#show"
end
