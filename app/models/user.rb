class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :content, :address, :first_name, :role, :last_name, presence: true
  validates :role, acceptance: { accept: ['admin', 'user'] }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :events, through: :attendance
  has_many :reviews
  has_many :teammates, through: :teammate_link
  has_many :created_events, foreign_key: :creator_id, class_name: :Event
end
