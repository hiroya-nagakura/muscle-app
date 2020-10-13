class CreateTargetSiteGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :target_sites do |t|
      t.string :muscle_name

      t.timestamps
    end
  end
end
