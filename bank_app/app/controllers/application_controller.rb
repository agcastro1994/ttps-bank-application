class ApplicationController < ActionController::Base
    before_action :set_current_user

    class NotAuthorizedError < StandardError; end
    class ItemDontExistError < StandardError; end
    class OfficeCantBeDeletedError < StandardError; end
    

    rescue_from NotAuthorizedError do
        redirect_to root_path, alert: "No tienes autorizacion suficiente"
    end

    rescue_from ItemDontExistError do
        redirect_to root_path, alert: "El item que buscaste no existe"
    end

    rescue_from OfficeCantBeDeletedError do
        redirect_to root_path, alert: "La sucursal no puede ser eliminada, tiene operadores o turnos asociados"
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
        is_authorized = Current.user.admin?
        raise NotAuthorizedError unless is_authorized        
    end

    def office_can_be_deleted? office
        operators = User.where('offices_id = ? and rol = ?', office.id, User.rols[:operator]).count
        appointments = Appointment.where('offices_id = ? and status = ?', office.id, Appointment.statuses[:pending]).count
        raise OfficeCantBeDeletedError unless operators + appointments == 0
    end

    def index_clients_authorization!
        is_authorized = Current.user.operator? || Current.user.admin?
        raise NotAuthorizedError unless is_authorized        
    end

    def show_clients_authorization! user
        is_authorized = Current.user.operator? || Current.user.admin?
        can_see_client = true
        if Current.user.operator?
            can_see_client = user.rol.client?
        end
        raise NotAuthorizedError unless is_authorized && can_see_client       
    end

    def can_create_appointment? user
        raise NotAuthorizedError unless user.client?
    end

    def can_see_appointment? appointment
        raise ItemDontExistError unless !appointment.cancelled?
        can_see_appointment = false
        
        if Current.user.client?
            can_see_appointment = Current.user.id == appointment.requester_id
        end 
        if Current.user.operator?
            office = Office.find(appointment.offices_id)
            can_see_appointment = office.id == Current.user.offices_id
        end
        raise NotAuthorizedError unless can_see_appointment
    end
end
