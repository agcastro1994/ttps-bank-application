module AppointmentForm
    class AppointmentDateController < ApplicationController

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
              date = Date.civil(params[:appointment_form_appointment_date][:year].to_i, params[:appointment_form_appointment_date][:month].to_i, params[:appointment_form_appointment_date][:day].to_i)
              #The value are temporarily stored in the session.
       
              session[:appointment_date] = {
                'date' => date                
              }
      
              redirect_to new_appointment_form_appointment_hour_path
            else              
              flash.now[:alert] = "Hubo un error al elegir fecha"
              @office = Office.find(session[:appointment_office]['offices_id'])  
              @reason = session[:appointment_office]['reason'] 
              render :new, status: :unprocessable_entity
            end
        end

        private

        def appointment_date_params
            params.required(:appointment_form_appointment_date).permit(:day, :year, :month)
        end

    end
end