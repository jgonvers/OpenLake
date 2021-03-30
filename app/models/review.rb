class Review < ApplicationRecord
  belongs_to :user
  belongs_to :event
  validates :rating, presence: true
end
