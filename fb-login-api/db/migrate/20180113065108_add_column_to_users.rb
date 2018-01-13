class AddColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    add_column :users, :token, :string
    add_column :users, :uid, :string
    add_column :users, :avatar, :string
  end
end
