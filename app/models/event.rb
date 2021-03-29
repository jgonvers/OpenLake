class Event < ApplicationRecord
  validates :title, :address, :datetime, :status, :content, :participants_maximum, presence: true

  has_many :reviews
  has_many :attendances
  has_many :users, through: :attendances
  belongs_to :creator, class_name: :User
  belongs_to :category
end
