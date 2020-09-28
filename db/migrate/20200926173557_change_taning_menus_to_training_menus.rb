class ChangeTaningMenusToTrainingMenus < ActiveRecord::Migration[6.0]
  def change
    rename_table :traning_menus, :training_menus
  end
end
