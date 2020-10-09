class AddReferencesToArticle < ActiveRecord::Migration[6.0]
  def change
    remove_column :articles, :target_site, :string
    add_reference :articles, :target_site, foreign_key: true
  end
end
