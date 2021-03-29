class Category < ApplicationRecord
  validates :name, :logo_link, presence: true
  validates :name, acceptance: { accept: ['football', 'rugby', 'running', 'swimming', 'handball', 'volleyball'] }
  has_many :events
end
