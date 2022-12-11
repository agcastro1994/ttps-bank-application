module AppointmentForm
    class AppointmentHour
      include ActiveModel::Model
      attr_accessor :hour
      validates :hour, presence: true      

        #Every shift reserves 30 minutes. This method calculate the amount of shift from a office's schedule
      def get_shifts_array(schedule, date)
        hour = schedule.start_at        
        shifts = []

        shifts_amount = Appointment.new.get_shifts_amount(schedule)

        #Iterates over the 30 min shift and populates the array of hours. 
        (1..shifts_amount).step(1) do
          hour_string = hour.strftime('%H:%M')
          operators = User.where("offices_id = ?", schedule.office_id).count
          day_appointments = Appointment.where("date= ? and offices_id=? ", date, schedule.office_id)
          hour_appointments = day_appointments.select {|a| a.hour.strftime('%H:%M') == hour_string } 
    
          if hour_appointments.size < operators            
            shifts.append([hour_string,hour_string])
          end
          hour = hour + 30.minutes
        end

        return shifts
      end
    end
end