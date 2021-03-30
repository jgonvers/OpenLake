class Category < ApplicationRecord
  validates :name, :logo_link, presence: true
  validates :name, acceptance: { accept: ['football', 'biking', 'running', 'swimming', 'bowling', 'volleyball'] }
  has_many :events
end
