class RemoveWeightFromTraningMenu < ActiveRecord::Migration[6.0]
  def change
    remove_column :records, :weight, :integer
    remove_column :records, :rep, :integer
    remove_column :records, :set, :integer
    rename_column :records, :menu, :main_target

    remove_column :traning_menus, :note, :integer
  end
end
