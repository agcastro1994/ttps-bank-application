class Appointment < ApplicationRecord
    enum status: { pending: 1, done: 2, in_progress: 3, cancelled: 4}
end
