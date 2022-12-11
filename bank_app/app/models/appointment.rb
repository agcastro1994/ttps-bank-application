class Appointment < ApplicationRecord
    enum status: { pending: 1, done: 2, in_progress: 3, cancelled: 4}

    def get_shifts_amount(schedule)
        return (schedule.end_at - schedule.start_at)/ 1.minutes/ 30
    end

    def get_index_for_user user
        if user.client?
            return Appointment.where('requester_id = ? and status <> ?', Current.user.id, Appointment.statuses[:cancelled])
        end

        if user.operator?
            return Appointment.where('offices_id = ? and status <> ?', Current.user.offices_id, Appointment.statuses[:cancelled])
        end
    end

end
