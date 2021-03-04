class AddUsernameToJoinGroup < ActiveRecord::Migration[6.0]
  def change
    add_column :join_groups, :username, :string
  end
end
