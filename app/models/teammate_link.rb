class TeammateLink < ApplicationRecord
  validates :status, acceptance: { accept: ['accepted', 'pending', 'declined'] }
  belongs_to :user
  belongs_to :teammate, class_name: :User
end
