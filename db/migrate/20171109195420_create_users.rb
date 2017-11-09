class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password
      t.boolean :admin
      t.boolean :gluten_free
      t.boolean :lactose_intol
      t.boolean :organic
      t.string :address

      t.timestamps null: false
    end
  end
end
