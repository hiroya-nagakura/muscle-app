class RemoveNeedFromArticle < ActiveRecord::Migration[6.0]
  def change
    remove_column :articles, :need, :string
    remove_column :articles, :recommended_target, :string
  end
end
