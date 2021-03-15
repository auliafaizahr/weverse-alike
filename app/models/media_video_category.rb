class MediaVideoCategory < ApplicationRecord
  belongs_to :group
  has_many   :media_videos
end
