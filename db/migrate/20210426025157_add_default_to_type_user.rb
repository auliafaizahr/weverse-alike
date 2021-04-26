class AddDefaultToTypeUser < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :type_user, 1
  end
end
