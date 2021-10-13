class UserGroup < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :group_id, uniqueness: { scope: :user_id, message: 'Can only join a group once'}
end
