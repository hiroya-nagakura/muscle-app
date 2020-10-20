class CreateTagGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :tag_groups do |t|
      t.string :name

      t.timestamps
    end
  end
end
