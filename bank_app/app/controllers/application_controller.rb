class ApplicationController < ActionController::Base
    before_action :set_current_user

    class NotAuthorizedError < StandardError; end

    rescue_from NotAuthorizedError do
        redirect_to root_path, alert: "No tienes autorizacion suficiente"
    end

    def set_current_user
        if session[:user_id]
            Current.user = User.find(session[:user_id])
        end
    end

    def check_user_is_logged!
        redirect_to sign_in_path, alert: "Debes iniciar sesion para acceder a las funcionalidades" if Current.user.nil?
    end

    def admin_authorization!
        is_authorized = Current.user.rol == 1
        raise NotAuthorizedError unless is_authorized        
    end

    def index_clients_authorization!
        is_authorized = Current.user.rol == 2 || Current.user.rol == 1
        raise NotAuthorizedError unless is_authorized        
    end

    def show_clients_authorization! user
        is_authorized = Current.user.rol == 2 || Current.user.rol == 1
        can_see_client = true
        if Current.user.rol == 2
            can_see_client = user.rol == 3
        end
        raise NotAuthorizedError unless is_authorized && can_see_client       
    end
end
