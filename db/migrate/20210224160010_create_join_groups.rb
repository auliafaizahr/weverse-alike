class CreateJoinGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :join_groups do |t|

      t.timestamps
    end
  end
end
