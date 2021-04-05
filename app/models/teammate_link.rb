class TeammateLink < ApplicationRecord
  validates :status, acceptance: { accept: ['accepted', 'pending', 'blocked'] }
  validates :user_id, uniqueness: { scope: :teammate_id }
  validates :teammate_id, exclusion: { in: ->(link) { [link.user_id] } }

  belongs_to :user
  belongs_to :teammate, class_name: :User
end
