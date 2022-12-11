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

    def new
      @office = Office.find(params[:office_id])     
      @days = get_week_days()
    end

    def create
        @office = Office.find(params[:office_id])
        days_params = params[:schedule][:days]
        days_params.shift()

        if empty_form_fields?(params[:schedule])
          flash[:alert] = "Debes llenar todos los campos"
          redirect_to office_schedules_path(params[:office_id]), status: :see_other and return
        end
        
        if Schedule.new.is_schedule_valid?(@office, days_params)
          @schedule = @office.schedules.create(schedule_params)
          puts @schedule
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
      
      if empty_form_fields?(params[:schedule])
        flash[:alert] = "Debes llenar todos los campos"
        redirect_to office_schedules_path(params[:office_id]), status: :see_other and return
      end

      if Schedule.new.is_schedule_edition_valid?(@office, @schedule, days_params)
        @schedule.update(schedule_params)
        
        flash[:notice] = "Horario editado"
        redirect_to @office
      else
        @days = get_week_days()
        flash.now[:alert] = "Estas intentando sobreescribir un dia que ya posee horario"
        render :edit, status: :unprocessable_entity      
      end        
    end

      private

        def empty_form_fields?(params)   
          return params[:days].length < 1
        end 

        #Private method to check the params of the form, to prevent any information injection
        def schedule_params
          params.require(:schedule).permit(:start_at, :end_at, :days => [])
        end

end
