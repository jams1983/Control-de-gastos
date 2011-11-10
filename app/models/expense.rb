class Expense < ActiveRecord::Base
  validates_uniqueness_of :service_id, :scope => [ :month, :year]
  validates_numericality_of :value
  validates_numericality_of :year
  validates_inclusion_of :month, :in => 1..12, :message => "has not selected"
  belongs_to :service
end
