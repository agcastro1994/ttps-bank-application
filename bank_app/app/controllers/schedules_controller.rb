class SchedulesController < ApplicationController
    before_action :admin_authorization!, :except => [:index, :show]

    def create
        @office = Office.find(params[:office_id])
        @schedule = @office.schedules.create(schedule_params)
        redirect_to office_path(@office)
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
    
    #def edit
     #   @office = Office.find(params[:office_id])
      #  @schedule = @office.schedules.find(params[:id])
    #end
    
    #def update
     #   @office = Office.find(params[:office_id])        
    
      #  if @office.schedules.update(schedule_params)
       #   redirect_to @office
       # else
        #  render :edit, status: :unprocessable_entity
      #  end
    #end

      private

        #Private method to check the params of the form, to prevent any information injection
        def schedule_params
          params.require(:schedule).permit(:days, :start_at, :end_at)
        end
end
