ActiveAdmin.register Tag do
  permit_params :name, :tag_group_id

  index do
    selectable_column
    id_column
    column :name
    column 'タググループ' do |tag|
      tag.tag_group.name
    end
    column :created_at
    column :updated_at
    actions
  end
  
end
