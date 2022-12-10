module AppointmentForm
    class AppointmentHour
      include ActiveModel::Model
      attr_accessor :hour
      validates :hour, presence: true      
    end
end