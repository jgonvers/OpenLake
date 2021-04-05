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

  # include PgSearch::Model
  # pg_search_scope :search_by_first_name_and_by_last_name,
  #   against: [ :first_name, :last_name],
  #   using: {
  #     tsearch: { prefix: true } # typing "maxime jo" will return "maxime jost"
  #   }

  def common_teammates(current_user)
    return "No common T-Mate" if current_user.nil?

    cu_teammates = current_user.accepted_teammates
    count = 0
    accepted_teammates.each do |teammate|
      count += 1 if cu_teammates.include? teammate
    end

    return "No common T-Mate" if count.zero?

    return "#{count} common T-Mates"
  end

  def distance_event(event)
    distance_to([event.latitude, event.longitude])
  end

  def teammates_in_event(event)
    team_event = event.users
    team_user = accepted_teammates
    team_event = team_event.select { |team| team_user.include? team }
    team_event << event.creator if team_user.include? event.creator
    return team_event
  end

  def teammates_in_event?(event)
    team = accepted_teammates
    event.users.each { |user| return true if team.include? user }

    return true if team.include? event.creator

    return false
  end

  def firstname_lastname_firstletter
    "#{first_name.capitalize} #{last_name.split('').first.capitalize}."
  end

  def accepted_teammates
    links = teammate_links
    links = links.select { |link| link.status == "accepted" }
    links.map(&:teammate)
  end
end
