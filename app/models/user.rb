class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :content, :address, :first_name, :role, :last_name, presence: true
  validates :role, acceptance: { accept: ['admin', 'user'] }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :attendances
  has_many :events, through: :attendances
  has_many :reviews
  has_many :teammate_link
  has_many :teammates, through: :teammate_link
  has_many :created_events, foreign_key: :creator_id, class_name: :Event

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def common_teammates
    count = 0
    teammates.each do |teammate|
      count += 1 if current_user.teammates.include? teammate
    end

    return "No common T-Mate" if count.zero?

    return "#{count} common T-Mates"
  end

  def distance_event(event)
    distance_to([event.latitude, event.longitude])
  end
end
