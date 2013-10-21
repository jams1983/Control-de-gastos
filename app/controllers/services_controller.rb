class ServicesController < ApplicationController
  def index
    #@services = Service.where(:user_id =>current_user.id)
    @services = current_user.services#.paginate(:per_page => 5, :page => params[:page])
    
    @dates = Array.new
    @services.each do |service|
      service.expenses.each do |ex|
        d = DateTime.new(ex.year,ex.month,1).strftime("%b/%y") 
        @dates.push(d)
      end
    end
    @dates = @dates.uniq
  end

  def edit
    @service = Service.find(params[:id])
  end

  def new
    @service = Service.new
  end
  
  def create
    @service = current_user.services.new(service_params)
    if @service.save
      redirect_to services_path, notice: 'Service was successfully created.'
    else
      render :new, alert: 'Error'
    end
  end
  
  def update
    @service =Service.find(params[:id])
    if @service.update_attributes(service_params)
      redirect_to services_path, notice: 'Service was successfully updated.'
    else
      render :edit, alert: 'Error'
    end
  end

  private

  def service_params
    params.require(:service).permit(:name)
  end
end
