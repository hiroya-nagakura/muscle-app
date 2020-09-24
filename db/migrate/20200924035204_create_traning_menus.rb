class CreateTraningMenus < ActiveRecord::Migration[6.0]
  def change
    create_table :traning_menus do |t|
      t.string :menu
      t.integer :weight
      t.integer :rep
      t.integer :set
      t.string :note
      t.references :record, null: false, foreign_key: true

      t.timestamps
    end
  end
end
