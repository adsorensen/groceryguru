class AddNameAndUnitToChecklist < ActiveRecord::Migration
  def change
    add_column :checkout_lists, :ingr_name, :string
    add_column :checkout_lists, :unit, :boolean
  end
end
