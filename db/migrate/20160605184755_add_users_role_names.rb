class AddUsersRoleNames < ActiveRecord::Migration
  def change
    add_column :users, :role_names, :string
  end
end
