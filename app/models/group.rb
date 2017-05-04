class Group < ApplicationRecord
  has_many :users, through: :users_groups
  has_many :user_groups
end
