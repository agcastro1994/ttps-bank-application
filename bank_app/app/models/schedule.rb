class Schedule < ApplicationRecord
  belongs_to :office

  serialize :days

  after_initialize do |schedule|
    schedule.days=[] if schedule.days == nil
  end

  validates :days, presence: {message: "Debe seleccionar minimo 1 dia"}
  validates :start_at, presence: {message: "Debe seleccionar una hora de inicio"}
  validates :end_at, presence: {message: "Debe seleccionar una hora de fin"}

  #Model methods to determine if a schedule can be edited or not
  #Ask if the schedule is the same for all the days of the week -> return valid and exit
  #Ask if the days of the update are a subset of the original dates -> return valid and exit
  #Creates an array diferent_days that contains days that are in update days but not in original days
  #Use that array in the is_schedule_valid? invocation and return the response
  def is_schedule_edition_valid?(office, schedule, days)
    original_set = Set.new
    update_set = Set.new
    diferent_days = days.map(&:clone)

    schedule.days.each do |day|
      original_set.add(day)
      diferent_days.delete(day)
    end
          
    if original_set.size == 7
      return true
    end          

    days.each do |d|
      update_set.add(d)           
    end

    if update_set.proper_subset? original_set
      return true
    end
          
    return is_schedule_valid?(office, diferent_days)

  end

  def is_schedule_valid?(office, days)
    is_valid = true
    set = Set.new
    office.schedules.each do |sc|
      sc.days.each do |d|
        set.add(d)               
      end
    end
          
    if set.size == 7
      is_valid = false
      return is_valid
    end

    days.each do |day|
      if set.include?(day)
        is_valid = false
      end
    end

    return is_valid          
  end
end
