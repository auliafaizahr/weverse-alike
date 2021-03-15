class AddThumbnailUrlToMediaVideo < ActiveRecord::Migration[6.0]
  def change
    add_column :media_videos, :thumbnail_url, :string
  end
end
