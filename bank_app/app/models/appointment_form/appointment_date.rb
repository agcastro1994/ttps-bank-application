module AppointmentForm
    class AppointmentDate
      include ActiveModel::Model
      attr_accessor :date
      validates :date, presence: {message: "Debe ingresar una fecha"}
      
      def user_has_appointment_for_date?(user_id, date, offices_id)         
        appointments = Appointment.where("date= ? and offices_id=? and requester_id=?", date, offices_id, user_id)
        return appointments.size > 0
      end
      
      #Check if the selected date has available appointments. Returns boolean 
      def date_availability(offices_id, date)
        if date.present?

          #Determine how many 30 min shifts are in the day's schedule
          schedule = Schedule.new.get_schedule_for_date(offices_id, date)

          #Check for days without bussiness hours. Handled as not available appointments
          if !schedule            
            return false
          end

          shifts_amount = Appointment.new.get_shifts_amount(schedule)

          #Search for workers amount in the office. The office can attend same amount of clients per shift
          operators = User.where("offices_id = ?", offices_id).count
          max_possible_appointments = shifts_amount * operators

          current_appointments = Appointment.where("date= ? and offices_id=?", date, offices_id).count
          if current_appointments < max_possible_appointments
            return true
          end          
        end
        return false
      end
    end
end