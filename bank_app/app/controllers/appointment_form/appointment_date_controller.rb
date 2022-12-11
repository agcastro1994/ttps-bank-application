module AppointmentForm
    class AppointmentDateController < ApplicationController
        include AppointmentForm
        def new
            @appointment_date = AppointmentDate.new

            @office = Office.find(session[:appointment_office]['offices_id'])  
            @reason = session[:appointment_office]['reason']          
        end
      
        def create   
            @appointment_date = AppointmentDate.new(appointment_date_params)
      
            # The valid? method is also called just the same
            # as for any Active Record object.
            if @appointment_date.valid?
              
              office_id = session[:appointment_office]['offices_id']
              date = params[:appointment_form_appointment_date][:date]             
              puts date
              if @appointment_date.user_has_appointment_for_date?(Current.user.id, date, office_id)
                flash.now[:alert] = "Ud ya tiene un turno para la fecha seleccionada"
                @office = Office.find(session[:appointment_office]['offices_id'])  
                @reason = session[:appointment_office]['reason'] 
                return render :new, status: :unprocessable_entity
              end

              available = @appointment_date.date_availability(office_id, date)

              if available
                #The value are temporarily stored in the session.  
                session[:appointment_date] = {
                  'date' => date                
                }
      
                redirect_to new_appointment_form_appointment_hour_path
              else
                flash.now[:alert] = "La fecha seleccionada no tiene turnos disponibles"
                @office = Office.find(session[:appointment_office]['offices_id'])  
                @reason = session[:appointment_office]['reason'] 
                render :new, status: :unprocessable_entity
              end
            else              
              flash.now[:alert] = "Hubo un error al elegir fecha"
              @office = Office.find(session[:appointment_office]['offices_id'])  
              @reason = session[:appointment_office]['reason'] 
              render :new, status: :unprocessable_entity
            end
        end

        private

        def appointment_date_params
            params.required(:appointment_form_appointment_date).permit(:date)
        end

    end
end