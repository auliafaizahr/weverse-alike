class JoinGroup < ApplicationRecord
  belongs_to :user
  belongs_to :group
end
