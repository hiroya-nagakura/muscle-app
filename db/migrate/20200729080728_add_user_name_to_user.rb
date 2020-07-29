class AddUserNameToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :user_name, :string
  end
end
