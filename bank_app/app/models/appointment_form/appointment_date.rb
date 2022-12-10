module AppointmentForm
    class AppointmentDate
      include ActiveModel::Model
      attr_accessor :day, :year, :month
      validates :day, presence: true    
      validates :year, presence: true 
      validates :month, presence: true   
    end
end