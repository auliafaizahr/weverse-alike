class CreateMediaVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :media_videos do |t|
      t.string :link, null: false
      t.string :title, null: false
      t.integer :category, null: false

      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
