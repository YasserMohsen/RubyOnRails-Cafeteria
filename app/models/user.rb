class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  has_many :orders
  belongs_to :room

  has_attached_file :avatar
  validates_attachment :avatar,
                       content_type: {content_type: ["image/jpeg", "image/gif", "image/png"]}
end
