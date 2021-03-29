class Event < ApplicationRecord
  has_many :reviews
  has_many :users, through: :attendance
  belongs_to :creator
  belongs_to :category
end
