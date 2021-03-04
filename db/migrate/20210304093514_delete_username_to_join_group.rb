class DeleteUsernameToJoinGroup < ActiveRecord::Migration[6.0]
  def change
    remove_column :join_groups, :username, :string
  end
end
