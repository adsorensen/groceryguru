class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.string :title
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :allday

      t.timestamps null: false
    end
  end
end
