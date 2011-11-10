class ServicesController < ApplicationController
  def index
    #@services = Service.where(:user_id =>current_user.id)
    @services = Service.where(:user_id =>current_user.id)#.paginate(:per_page => 5, :page => params[:page])
    puts "S",@services.to_s
    @dates=Array.new
    @services.each do |service|
      service.expenses.each do |ex|
        d=DateTime.new(ex.year,ex.month,1).strftime("%b/%y") 
        @dates.push(d)
      end
    end
    @dates=@dates.uniq
    puts "el valor",@dates
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user }
    end
  end
  def show
    puts "show"
  end
  def edit
    puts params[:id]
    @service = Service.find(params[:id])
  end
  def new
    @service = Service.new
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user }
    end
  end
  
  def create
    @service=current_user.services.new(params[:service])
    respond_to do |format|
      if @service.save
        format.html { redirect_to services_path, notice: 'Service was successfully created.' }
        format.json { render json: @service, status: :created, location: @service }
      else
        format.html { render action: "new" }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    @service =Service.find(params[:id])
    respond_to do |format|
      if @service.update_attributes(params[:service])
        format.html { redirect_to services_path, notice: 'Service was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end
end
