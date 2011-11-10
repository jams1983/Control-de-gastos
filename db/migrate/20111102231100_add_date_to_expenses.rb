class AddDateToExpenses < ActiveRecord::Migration
  def self.up
    add_column :expenses, :year, :integer
    add_column :expenses, :month, :integer    
  end
  
  def self.down
    remove_column :expenses, :year
    remove_column :expenses, :month
  end
end
