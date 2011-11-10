class HomeController < ApplicationController
  def index
    puts 'entra home'
    if user_signed_in?
      st_users=SharedTimeUser.where(:user_id =>current_user.id).order("created_at DESC")
      @expenses=Array.new
      st_users.each do |st_user|
          @expenses.concat(Expense.joins(:service).where(:services =>{:user_id =>st_user.shared_time.user_id}).where(:month =>st_user.shared_time.month).where(:year =>st_user.shared_time.year))      
      end
      @expenses.each do |expense|
        p expense.service.name
      end
    else
      p "no inicio session"
      
    end
  end

end
