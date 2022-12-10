module AppointmentForm
    class AppointmentHourController < ApplicationController

        def new
            @appointment_hour = AppointmentHour.new

            @office = Office.find(session[:appointment_office]['offices_id'])  
            @date =  session[:appointment_date]['date']
            @reason = session[:appointment_office]['reason']        
        end
      
        def create
            puts params.inspect
            @appointment_hour = AppointmentHour.new(appointment_hour_params)
    
            # The valid? method is also called just the same
            # as for any Active Record object.
            if @appointment_hour.valid?
      
              #restore all data from previous steps.
              full_params = appointment_hour_params.merge(
                date: session[:appointment_date]['date'],   
                offices_id: session[:appointment_office]['offices_id'],
                reason: session[:appointment_office]['reason'],
                requester_id: Current.user.id
              )
              
              @appointment = Appointment.create!(full_params)
              @appointment.pending!

              session.delete('appointment_date')
              session.delete('appointment_office')
              
              flash[:notice] = "Turno solicitado exitosamente"
              redirect_to root_path
            else              
              flash.now[:alert] = "Hubo un error al elegir fecha"
              @office = Office.find(session[:appointment_office]['offices_id'])  
              @date =  session[:appointment_date]['date'] 
              render :new, status: :unprocessable_entity
            end
        end

        private

        def appointment_hour_params
            params.required(:appointment_form_appointment_hour).permit(:hour)
        end

    end
end