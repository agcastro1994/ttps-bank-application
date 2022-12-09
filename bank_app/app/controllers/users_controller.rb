class UsersController < ApplicationController

    before_action :admin_authorization!, :except => [:index, :show]

    def new_operator
        @user = User.new
        @offices = []
        all_offices = Office.all

        all_offices.each do |office|
            @offices.append([office.name, office.id])
        end

    end

    def create_operator
        @user = User.new(operator_params_validated)
        @user.operator!
        if @user.save            
            redirect_to root_path, notice: "Usuario creado correctamente"
        else
            @offices = []
            all_offices = Office.all

            all_offices.each do |office|
                @offices.append([office.name, office.id])
            end
            flash.now[:alert] = "Hubo un error creando su usuario"
            render :new_operator, status: :unprocessable_entity
        end
    end

    def new_admin
        @user = User.new
    end

    def create_admin
        @user = User.new(user_params_validated)
        @user.admin!
        if @user.save            
            redirect_to root_path, notice: "Usuario creado correctamente"
        else
            flash.now[:alert] = "Hubo un error creando su usuario"
            render :new_admin, status: :unprocessable_entity
        end
    end

    def index
        index_clients_authorization!
        @users = Current.user.rol == "operator" ? User.where(rol: 3) : User.all
    end

    def show
        @user = User.find(params[:id])
        show_clients_authorization! @user  

        @office = nil
        if @user.operator?
            @office = Office.find(@user.offices_id)
        end
    end

    def edit
        @user = User.find(params[:id])
        @offices = []
        all_offices = Office.all

        all_offices.each do |office|
            @offices.append([office.name, office.id])
        end
    end
    
    def update
        @user = User.find(params[:id])
        update_params = @user.rol == "operator" ? operator_params_validated : user_params_validated
        puts update_params
        if @user.update_column(:email, update_params[:email]) && @user.update_column(:offices_id, update_params[:offices_id])

          redirect_to @user
        else
          render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @user = User.find(params[:user_id])
        @user.destroy
    
        redirect_to users_path, status: :see_other
    end

    private

    #Private method to check the params of the form, to prevent any information injection
    def user_params_validated
        params.required(:user).permit(:email, :password, :password_confirmation)
    end

    def operator_params_validated
        params.required(:user).permit(:email, :password, :password_confirmation, :offices_id)
    end
end