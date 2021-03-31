class Event < ApplicationRecord
  validates :title, :address, :start_time, :end_time, :status, :content, :participants_maximum, presence: true

  has_many :reviews
  has_many :attendances
  has_many :users, through: :attendances
  belongs_to :creator, class_name: :User
  belongs_to :category

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def <=>(other)
    val = 0
    # val = current_user.distance_event(self) <=> current_user.distance_event(other) if user_signed_in?
    val = start_time <=> other.start_time if val.zero?
    return val
  end
end
