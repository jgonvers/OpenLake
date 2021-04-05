class TeammateLink < ApplicationRecord
  validates :status, acceptance: { accept: ['accepted', 'pending', 'blocked'] }
  belongs_to :user
  belongs_to :teammate, class_name: :User
end
