class AppointmentsController < ApplicationController

    def get_office
        @appointment = Appointment.new
        @offices = Office.new.get_offices_names
    end

    def set_office
        @office = Office.find(params[:office_id])
        @days = AppointmentsHelper.get_next_month_days
    end

    def new
        #@appointment = Appointment.new
        #@offices = Office.new.get_offices_names     
    end

    def create
        @appointment = Appointment.new(appointment_params_validated)
        @appointment.requester_id = Current.user.id
        @appointment.pending!    

        if @appointment.save            
            redirect_to root_path, notice: "Turno solicitado correctamente"
        else
            @offices = Office.new.get_offices_names
            
            flash.now[:alert] = "Hubo un error solicitando su turno"
            render :new, status: :unprocessable_entity
        end
    end



    private

    def appointment_params_validated
        params.required(:appointment).permit(:offices_id, :date, :hour, :reason)
    end

end