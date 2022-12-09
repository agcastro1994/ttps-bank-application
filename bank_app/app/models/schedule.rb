class Schedule < ApplicationRecord
  belongs_to :office

  serialize :days

  after_initialize do |schedule|
    schedule.days=[] if schedule.days == nil
  end

  validates :days, presence: {message: "Debe seleccionar minimo 1 dia"}
  validates :start_at, presence: {message: "Debe seleccionar una hora de inicio"}
  validates :end_at, presence: {message: "Debe seleccionar una hora de fin"}
end
