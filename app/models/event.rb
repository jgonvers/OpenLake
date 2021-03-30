class Event < ApplicationRecord
  validates :title, :address, :start_time, :end_time, :status, :content, :participants_maximum, presence: true

  has_many :reviews
  has_many :attendances
  has_many :users, through: :attendances
  belongs_to :creator, class_name: :User
  belongs_to :category

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

end
