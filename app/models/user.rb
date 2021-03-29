class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :events, through: :attendance
  has_many :reviews
  has_many :teammates
  has_many :created_events, foreign_key: :creator_id, class_name: :Event
end
