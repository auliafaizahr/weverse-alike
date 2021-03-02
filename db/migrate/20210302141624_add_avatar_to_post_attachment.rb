class AddAvatarToPostAttachment < ActiveRecord::Migration[6.0]
  def change
    add_column :post_attachments, :avatar, :string
  end
end
