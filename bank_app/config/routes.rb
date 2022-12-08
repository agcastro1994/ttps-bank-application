Rails.application.routes.draw do
  root "home#home"

  #Office and schedules routes
  resources :offices do
    resources :schedules
    post "/delete", :to => "offices#destroy", :as => "delete"
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
