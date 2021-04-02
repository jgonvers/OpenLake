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
  has_one_attached :photo

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def common_teammates(current_user)
    return "No common T-Mate" if current_user.nil?

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

  def teammates_in_event(event)
    team_event = event.users
    team_user = teammates
    team_event = team_event.select { |team| team_user.include? team }
    team_event << event.creator if team_user.include? event.creator
    return team_event
  end

  def teammates_in_event?(event)
    team = teammates
    event.users.each { |user| return true if team.include? user }

    return true if team.include? event.creator

    return false
  end
end
