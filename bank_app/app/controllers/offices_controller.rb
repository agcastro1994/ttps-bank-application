class OfficesController < ApplicationController
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
      redirect_to @office
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @office = Office.find(params[:id])
  end

  def update
    @office = Office.find(params[:id])

    if @office.update(article_params)
      redirect_to @office
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @office = Office.find(params[:id])
    @office.destroy

    redirect_to offices_path, status: :see_other
  end

  private
    def office_params
      params.require(:office).permit(:name, :address, :phone)
    end

end
