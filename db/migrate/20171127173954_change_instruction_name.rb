class ChangeInstructionName < ActiveRecord::Migration
  def change
    rename_column :recipes, :instructions, :directions
  end
end
