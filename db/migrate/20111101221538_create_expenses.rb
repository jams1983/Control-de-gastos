class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.float :value
      t.references :service

      t.timestamps
    end
    add_index :expenses, :service_id
  end
end
