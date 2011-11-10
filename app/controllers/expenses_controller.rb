class ExpensesController < ApplicationController
  def index
    #@expenses = Expense.where(:service_id => params[:format])
    @service = Service.find(params[:service_id])
    @expenses= Expense.where(:service_id => @service.id).order(:year,:month)#.paginate(:per_page => 5, :page => params[:page])
    @dates=Array.new
    @expenses.each do |ex|
      d=DateTime.new(ex.year,ex.month,1).strftime("%b/%y") 
      @dates.push(d)
    end
    puts "el valor",@dates
  end
  def new
    @service = Service.find(params[:service_id])
    @expense = Expense.new
    @expense.service=@service
    puts "este ",@expense.service.id
  end
  def create
    @service = Service.find(params[:service_id])
    @expense = @service.expenses.new(params[:expense])
    respond_to do |format|
      if @expense.save
        format.html { redirect_to service_expenses_path(@service), notice: 'Expense was successfully created.' }
        format.json { render json: @expense, status: :created, location: @expense }
      else
        format.html { render action: "new" }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
    
  end
  def edit
    @service = Service.find(params[:service_id])
    @expense=Expense.find(params[:id])
  end
  def update
    @service = Service.find(params[:service_id])
    @expense =Expense.find(params[:id])
    respond_to do |format|
      if @expense.update_attributes(params[:expense])
        format.html { redirect_to service_expenses_path(@expense.service), notice: 'Expense was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end
  def destroy
    @expense = Expense.find(params[:id])
    @service = @expense.service
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to service_expenses_path(@service) }
      format.json { head :ok }
    end
  end

end
