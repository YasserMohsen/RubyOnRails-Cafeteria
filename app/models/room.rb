class Room < ApplicationRecord
  validates :name, presence: true
  has_many :users
  has_many :orders
end
