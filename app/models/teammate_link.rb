class TeammateLink < ApplicationRecord
  validates :status, acceptance: { accept: ['accepted', 'pending', 'blocked'] }
  validates :user_id, uniqueness: { scope: :teammate_id }
  belongs_to :user
  belongs_to :teammate, class_name: :User
end
