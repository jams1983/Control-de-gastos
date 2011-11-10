class CreateSharedTimeUsers < ActiveRecord::Migration
  def change
    create_table :shared_time_users do |t|
      t.references :shared_time
      t.references :user

      t.timestamps
    end
    add_index :shared_time_users, :shared_time_id
    add_index :shared_time_users, :user_id
  end
end
