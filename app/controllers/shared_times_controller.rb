class SharedTimesController < ApplicationController
  def index
    @shared_times = SharedTime.where(:user_id =>current_user.id)
    @users=User.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users.map(&:attributes) }
    end
  end
  def edit
    puts params[:id]
    @shared_time = SharedTime.find(params[:id])
    @array_users=Array.new
    @shared_time.st_users.each do |user|
      hash_users=Hash.new
      hash_users['id'] = user.id
      hash_users['name']= user.email
      @array_users.push(hash_users)
    end
  end
  def new
    @shared_time = SharedTime.new
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user }
    end
  end
  def create
    @shared_time=current_user.shared_times.new(params[:shared_time])
    
    respond_to do |format|
      if @shared_time.save
        #@shared_time.st_users=params[:st_users][:user_ids] ||= []
        format.html { redirect_to shared_times_path, notice: 'Service was successfully created.' }
        format.json { render json: @shared_time, status: :created, location: @shared_time }
      else
        format.html { render action: "new" }
        format.json { render json: @shared_time.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    @shared_time =SharedTime.find(params[:id])
    respond_to do |format|
      if @shared_time.update_attributes(params[:shared_time])
        format.html { redirect_to shared_times_path, notice: 'shared time was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @shared_time.errors, status: :unprocessable_entity }
      end
    end
  end
end
