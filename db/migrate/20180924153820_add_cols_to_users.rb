class AddColsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :username, :string
    add_column :users, :avatar, :string
    add_column :users, :following, :text
  end
end
