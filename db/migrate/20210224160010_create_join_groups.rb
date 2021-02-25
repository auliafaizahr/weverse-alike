class CreateJoinGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :join_groups do |t|
      t.references :user, null: false
      t.references :group, null: false
      t.timestamps
    end
  end
end
