class CreateSharedTimes < ActiveRecord::Migration
  def change
    create_table :shared_times do |t|
      t.integer :month
      t.integer :year
      t.references :user

      t.timestamps
    end
    add_index :shared_times, :user_id
  end
end
