class DeleteCategoryInMediaVideo < ActiveRecord::Migration[6.0]
  def change
    remove_column :media_videos, :category, :integer

    add_reference :media_videos, :media_video_category, foreign_key: true
  end
end
