class AppointmentsController < ApplicationController

    def new

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

    def complete      

        @appointment = Appointment.find(params[:appointment_id])
        can_see_appointment?(@appointment)
        if @appointment.update(complete_appointment_params_validated)
            @appointment.done!
            @appointment.update_column(:operator_id, Current.user.id)
            redirect_to appointments_path
        else
            flash.now[:alert] = "El turno no pudo ser resuelto"
            render :show, status: :unprocessable_entity
        end
    end

    def destroy
        @appointment = Appointment.find(params[:appointment_id])
        @appointment.cancelled!

        redirect_to appointments_path, status: :see_other

    end

    def create

    end



    private

    def appointment_params_validated
        params.required(:appointment).permit(:offices_id, :date, :hour, :reason)
    end

    def complete_appointment_params_validated
        params.required(:appointment).permit(:comment)
    end

end