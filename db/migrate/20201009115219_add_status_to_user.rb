class AddStatusToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :bodyweights_is_released, :boolean, default: true, null: false
    add_column :users, :records_is_released, :boolean, default: true, null: false
  end
end
