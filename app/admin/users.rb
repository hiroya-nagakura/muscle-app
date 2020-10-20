ActiveAdmin.register User do
  permit_params :email, :user_name, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :user_name
    column 'フォロー数' do |user|
      user.followings.count
    end
    column 'フォロワー数' do |user|
      user.followers.count
    end
    column 'いいね数' do |user|
      user.favorite_articles.count
    end
    column :created_at
    column :updated_at
    actions
  end
  form do |f|
    f.inputs do
      f.input :email
      f.input :user_name
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  show do |user|
    attributes_table(*user.class.columns.collect { |column| column.name.to_sym })
    panel 'プロフィール画像' do
      if user.image?
        image_tag user.image.url(:thumb)
      else
        image_tag '/assets/default.png'
      end
    end
    panel 'フォロー' do
      table_for user.followings do
        column :id
        column :user_name
      end
    end
    panel 'フォロワー' do
      table_for user.followers do
        column :id
        column :user_name
      end
    end
    panel 'いいね' do
      table_for user.favorite_articles do
        column :id
        column :title
        column :target_site
      end
    end
    active_admin_comments
  end
end
