class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.references :user

      t.timestamps
    end
    add_index :services, :user_id
  end
end
