class UsersController < ApplicationController
  def index
    @users=User.all
    @array_users=Array.new
    @users.each do |user|
      hash_users=Hash.new
      hash_users['id'] = user.id
      hash_users['name']= user.email
      @array_users.push(hash_users)
    end
    
    respond_to do |format|
      format.html
      format.json { render :json => @array_users}
    end
  end
end
