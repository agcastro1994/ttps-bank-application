class Schedule < ApplicationRecord
  belongs_to :office

  serialize :days

  after_initialize do |schedule|
    schedule.days=[] if schedule.days == nil
  end
end
