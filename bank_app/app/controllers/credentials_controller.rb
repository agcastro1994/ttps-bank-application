class CredentialsController < ApplicationController
    before_action :check_user_is_logged!, :except => [:reset, :reset_password, :reset_edit, :reset_update]

    def edit
    end

    def update
        if Current.user.update(password_params)
            redirect_to root_path, notice: "Clave actualizada correctamente"
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def reset
    end

    #Mailing method to restore the password. 
    #Set to deliver later to trigger background job, instead of waiting for the email to response
    def reset_password
     
        @user = User.find_by(email: params[:email])

        if @user.present?
            PasswordMailer.with(user: @user).reset.deliver_later
        end
        redirect_to root_path, notice: "Si el email es correcto, hemos enviado un correo para reiniciar su clave"
    end

    #Method to restore the password. 
    #Receive the unique signed token and after verifying it, render the form to restore password
    def reset_edit
        @user = User.find_signed(params[:token], purpose: "password_reset")
        #binding.irb --> Debug in console
    rescue ActiveSupport::MessageVerifier::InvalidSignature
        redirect_to sign_in_path, alert: "Token expirado, intente de nuevo"
    end

    def reset_update
        @user = User.find_signed(params[:token], purpose: "password_reset")
        if @user.update(password_params)
            redirect_to sign_in_path, notice: "Clave reiniciada con exito, inicie sesion"
        else
            render :reset_edit, status: :unprocessable_entity
        end
    end

    private

    #Private method to check the params of the form, to prevent any information injection
    def password_params
        params.required(:user).permit(:password, :password_confirmation)
    end
end