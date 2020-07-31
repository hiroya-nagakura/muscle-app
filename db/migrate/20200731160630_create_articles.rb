class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string  :title, null: false
      t.string  :target_site, null: false
      t.string  :need
      t.string  :recommended_target
      t.text  :body, null: false
      t.text  :important_point
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
