class ChangeAmountToFloat < ActiveRecord::Migration
  def change
    change_column :instructions, :amount, :float
  end
end
