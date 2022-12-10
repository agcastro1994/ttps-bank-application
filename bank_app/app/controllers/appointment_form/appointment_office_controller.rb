module AppointmentForm
    class AppointmentOfficeController < ApplicationController

        def new
            @appointment_office = AppointmentOffice.new
            @offices = Office.new.get_offices_names
        end
      
        def create

            @appointment_office = AppointmentOffice.new(appointment_office_params)
      
            # The valid? method is also called just the same
            # as for any Active Record object.
            if @appointment_office.valid?
      
              #The value are temporarily stored in the session.
              session[:appointment_office] = {
                'offices_id' => @appointment_office.offices_id,
                'reason' => @appointment_office.reason
              }
      
              redirect_to new_appointment_form_appointment_date_path
            else
              @offices = Office.new.get_offices_names
              flash.now[:alert] = "Hubo un error al elegir sucursal"
              render :new, status: :unprocessable_entity
            end
        end

        private

        def appointment_office_params
            params.required(:appointment_form_appointment_office).permit(:offices_id,:reason)
        end

    end
end