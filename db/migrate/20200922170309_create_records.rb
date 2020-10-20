class CreateRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :records do |t|
      t.string :menu
      t.integer :weight
      t.integer :rep
      t.integer :set
      t.datetime :start_time
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
