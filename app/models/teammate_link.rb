class TeammateLink < ApplicationRecord
  belongs_to :user
  belongs_to :teammate
end
