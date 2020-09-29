class CreateBodyweights < ActiveRecord::Migration[6.0]
  def change
    create_table :bodyweights do |t|
      t.integer :weight
      t.date :day
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
