class ExpensesController < ApplicationController
  def index
    #@expenses = Expense.where(:service_id => params[:format])
    @service = Service.find(params[:service_id])
    @expenses= Expense.where(:service_id => @service.id).order(:year,:month)#.paginate(:per_page => 5, :page => params[:page])
    first_expense=@expenses.first
    last_expense=@expenses.last
    
    #obtiene los meses entre los años min y max de los expenses
    num_meses=Array.new
    if @expenses.size>0
      if first_expense.year==last_expense.year
        num_meses=(first_expense.month..last_expense.month).collect{|x| DateTime.new(first_expense.year,x,1)}
      else
        if last_expense.year-first_expense.year==1
          num_meses=(first_expense.month..12).to_a.collect{|x| DateTime.new(first_expense.year,x,1)}
          num_meses.concat((1..last_expense.month).to_a.collect{|x| DateTime.new(last_expense.year,x,1)})
        else
          num_meses=(first_expense.month..12).to_a.collect{|x| DateTime.new(first_expense.year,x,1)}
          years=(first_expense.year+1...last_expense.year).to_a
          years.each do |year|
            num_meses.concat((1..12).to_a.collect{|x| DateTime.new(year,x,1)})
          end
          num_meses.concat((1..last_expense.month).to_a.collect{|x| DateTime.new(last_expense.year,x,1)})
        
        end
      end
      #obtiene los values de cada uno de los meses antes obtenidos, sino tiene value se le asigna nil
      @vals=Array.new
      num_meses.each do |nm|
        exp = Expense.where(:service_id => @service.id).where(:year =>nm.year).where(:month =>nm.month)
        if exp.size==0
          @vals.push(nil)
        else
          @vals.push(exp[0].value)
        end
      end
    end

    #se obtienen los meses con formato mes/año para pasarlos a la vista
    @dates=Array.new
    num_meses.each do |nm|
      d=nm.strftime("%b/%y") 
      @dates.push(d)
    end

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
