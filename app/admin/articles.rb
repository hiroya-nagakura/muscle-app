ActiveAdmin.register Article do
  index do
    selectable_column
    id_column
    column :title
    column :target_sites_id
    column :important_point
    column '記事内容', class: :admin_article_content do |article|
      article.content.to_s
    end
    column 'いいね数' do |article|
      article.favorites.count
    end
    column 'コメント数' do |article|
      article.comments.count
    end
    column :created_at
    column :updated_at
    actions
  end

  show do |article|
    attributes_table(*article.class.columns.collect { |column| column.name.to_sym })
    panel '記事内容' do
      article.content
    end
    panel 'いいねしたユーザー' do
      table_for article.favorites do
        column :user
      end
    end
    panel 'コメント内容' do
      table_for article.comments do
        column :user
        column :content
      end
    end
    active_admin_comments
  end
end
