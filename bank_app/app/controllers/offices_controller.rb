class OfficesController < ApplicationController

  before_action :admin_authorization!, :except => [:index, :show]

  def index
    @offices = Office.all
  end

  def show
    @office = Office.find(params[:id])
    
  end

  def new
    @office = Office.new
  end

  def create
    @office = Office.new(office_params)

    if @office.save
      flash[:notice] = "La sucursal creada exitosamente"
      redirect_to @office
    else
      flash.now[:alert] = "La sucursal no pudo ser creada"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @office = Office.find(params[:id])
  end

  def update
    @office = Office.find(params[:id])

    if @office.update(office_params)
      redirect_to @office
    else
      flash.now[:alert] = "La sucursal no pudo ser editada"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @office = Office.find(params[:office_id])
    office_can_be_deleted?(@office)
    
    @office.destroy

    redirect_to offices_path, status: :see_other
  end

  private
  
    #Private method to check the params of the form, to prevent any information injection
    def office_params
      params.require(:office).permit(:name, :address, :phone)
    end

end
