class CreateMediaVideoCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :media_video_categories do |t|
      t.string :name, null: false
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
