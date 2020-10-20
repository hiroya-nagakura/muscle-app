ActiveAdmin.register Record do
  show do |record|
    attributes_table(*record.class.columns.collect { |column| column.name.to_sym })
    panel 'メニュー' do
      table_for record.training_menus do
        column :menu
        column :weight
        column :rep
        column :set
      end
    end
  end
end
