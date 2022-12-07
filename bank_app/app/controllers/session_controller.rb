class SessionController < ApplicationController
    def login
    end

    def create_session
        user = User.find_by(email: params[:email])
        if user.present? && user.authenticate(params[:password])
            session[:user_id] = user.id
            flash[:success] = "Inicio de sesion exitoso"
            redirect_to root_path, notice: "Inicio de sesion exitoso"
        else
            flash[:alert] = "Email o clave invalida"
            render :login
        end
    end

    def logout
        session[:user_id]=nil
        redirect_to root_path, notice: "Sesion cerrada"
    end

end
