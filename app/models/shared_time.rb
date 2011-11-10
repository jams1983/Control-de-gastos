class SharedTime < ActiveRecord::Base
  attr_accessible :shared_time_user_tokens,:month,:year
  belongs_to :user
  has_many :shared_time_users
  has_many :st_users, :through => :shared_time_users, :source => :user
  attr_reader :shared_time_user_tokens
  
  def shared_time_user_tokens=(ids)
    self.st_users=User.find(ids.split(/,/))
  end
end
