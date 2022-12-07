class RegistrationController < ApplicationController
    def register
        @user = User.new
    end

    def create_user
        @user = User.new(user_params_validated)
        @user.rol = 2
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path, notice: "Usuario creado correctamente"
        else
            #flash[:alert] = "Hubo un error creando su usuario"
            render :register
        end
    end

    private
    
    def user_params_validated
        params.required(:user).permit(:email, :password, :password_confirmation)
    end
end