module AppointmentForm
    class AppointmentOffice
      include ActiveModel::Model
      attr_accessor :offices_id, :reason
      validates :offices_id, presence: true
      validates :reason, presence: true
    end
end