class Office < ApplicationRecord
    has_many :schedules, dependent: :destroy

    validates :name, presence: true
    validates :address, presence: true
    validates :phone, presence: true, length: { minimum: 10 }
end
