class AppointmentsController < ApplicationController

    def new
        #@appointment = Appointment.new
        #@offices = Office.new.get_offices_names     
    end

    def index
        @appointments = Appointment.new.get_index_for_user(Current.user)
    end

    def show
        @appointment = Appointment.find(params[:id])
        can_see_appointment?(@appointment)

        @office = Office.find(@appointment.offices_id)  
        @operator = ""   
        @user = User.find(@appointment.requester_id) 
        if @appointment.done?
            operator_query = User.find(@appointment.operator_id)
            if operator_query
                @operator = operator_query.email           
            end
        end
    end

    def destroy
        @appointment = Appointment.find(params[:appointment_id])
        @appointment.cancelled!

        redirect_to appointments_path, status: :see_other

    end

    def create
        # @appointment = Appointment.new(appointment_params_validated)
        # @appointment.requester_id = Current.user.id
        # @appointment.pending!    

        # if @appointment.save            
        #     redirect_to root_path, notice: "Turno solicitado correctamente"
        # else
        #     @offices = Office.new.get_offices_names
            
        #     flash.now[:alert] = "Hubo un error solicitando su turno"
        #     render :new, status: :unprocessable_entity
        # end
    end



    private

    def appointment_params_validated
        params.required(:appointment).permit(:offices_id, :date, :hour, :reason)
    end

end