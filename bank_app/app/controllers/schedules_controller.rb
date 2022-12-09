class SchedulesController < ApplicationController
    before_action :admin_authorization!, :except => [:index, :show]

    DAYS = [
      "Lunes",
      "Martes",
      "Miercoles",
      "Jueves",
      "Viernes",
      "Sabado",
      "Domingo"
    ]
    def get_week_days
      days = []

      DAYS.each do |day|
        days.append([day,day])
      end

      return days
    end

    def create
        @office = Office.find(params[:office_id])
        days_params = params[:schedule][:days]
        days_params.shift()
        
        if is_schedule_valid?(@office, days_params)
          @schedule = @office.schedules.create(days: days_params, start_at: params[:schedule][:start_at], end_at: params[:schedule][:end_at])
          flash[:notice] = "Horario agregado"
          redirect_to office_schedules_path(params[:office_id])
        else 
          flash[:alert] = "Estas intentando sobreescribir un dia que ya posee horario"
          redirect_to office_schedules_path(params[:office_id]), status: :see_other
        end
    end
    
    def destroy
        @office = Office.find(params[:office_id])
        @schedule = @office.schedules.find(params[:id])
        @schedule.destroy
        redirect_to office_path(@office), status: :see_other
    end

    def index
      @office = Office.find(params[:office_id])
      @days = get_week_days()
    end

    def show

    end
    
    def edit
     @office = Office.find(params[:office_id])
     @schedule = @office.schedules.find(params[:id])

     @days = get_week_days()
    end
    
    def update
      @office = Office.find(params[:office_id])        
      @schedule = Schedule.find(params[:id])

      days_params = params[:schedule][:days]
      days_params.shift()
      
      puts params[:schedule]
      if is_schedule_edition_valid?(@office, @schedule, days_params)
        @schedule.update(days: days_params, start_at: params[:schedule][:start_at], end_at: params[:schedule][:end_at])
        
        flash[:notice] = "Horario editado"
        redirect_to @office
      else
        @days = get_week_days()
        flash.now[:alert] = "Estas intentando sobreescribir un dia que ya posee horario"
        render :edit, status: :unprocessable_entity      
      end        
    end

      private

        #Private method to check the params of the form, to prevent any information injection
        def schedule_params
          params.require(:schedule).permit(:days, :start_at, :end_at)
        end

        #Private method to determine if a schedule can be edited or not
        #Ask if the schedule is the same for all the days of the week -> return valid and exit
        #Ask if the days of the update are a subset of the original dates -> return valid and exit
        #Creates an array diferent_days that contains days that are in update days but not in original days
        #Use that array in the is_schedule_valid? invocation and return the response
        def is_schedule_edition_valid?(office, schedule, days)
          original_set = Set.new
          update_set = Set.new
          diferent_days = days.map(&:clone)

          @schedule.days.each do |day|
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
