Rails.application.routes.draw do
  root "home#home"

  resources :offices do
    resources :schedules
    post "/delete", :to => "offices#destroy", :as => "delete"
  end
  
  
  get "sign_up", to: "registration#register"
  post "sign_up", to: "registration#create_user"

  get "sign_in", to: "session#login"
  post "sign_in", to: "session#create_session"
  delete "logout", to: "session#logout"

end
