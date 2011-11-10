class SharedTimeUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :shared_time
end
