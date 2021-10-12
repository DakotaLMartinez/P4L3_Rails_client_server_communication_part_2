class Group < ApplicationRecord
  has_many :events
  has_many :user_groups
  has_many :members, through: :user_groups, source: :user
end
