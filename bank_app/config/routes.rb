Rails.application.routes.draw do
  root "home#home"

  #Office and schedules routes
  resources :offices do
    resources :schedules
    post "/delete", :to => "offices#destroy", :as => "delete"
  end

  resources :users do
    post "/delete", :to => "users#destroy", :as => "delete"
  end

  #Special users routes (operators, admin)
  get  "/users/admin/new", :to => "users#new_admin"
  post "/users/admin/new", :to => "users#create_admin", :as => "create_admin"
  get  "/users/operator/new", :to => "users#new_operator"
  post "/users/operator/new", :to => "users#create_operator", :as => "create_operator"

  #Appointment routes
  resources :appointments do
    # get "/office/select", :to => "appointments#get_office"
    # post "/office/select", :to => "appointments#set_office"
    # get "/date/select", :to => "appointments#get_date"
    # post "/date/select", :to => "appointments#set_date"
  end

  namespace :appointment_form do
    resources :appointment_office, only: %i[new create]
    resources :appointment_date, only: %i[new create]
    resources :appointment_hour, only: %i[new create]
  end
  
  
  #Credential routes. Include change/restore password
  get "password", to: "credentials#edit", as: :change_password
  patch "password", to: "credentials#update"
  get "password/reset", to: "credentials#reset"
  post "password/reset", to: "credentials#reset_password", as: :reset_password
  get "password/reset/edit", to: "credentials#reset_edit"
  patch "password/reset/edit", to: "credentials#reset_update"
  
  #Register routes. 
  get "sign_up", to: "registration#register"
  post "sign_up", to: "registration#create_user"

  #Session routes
  get "sign_in", to: "session#login"
  post "sign_in", to: "session#create_session"
  delete "logout", to: "session#logout"

end
