class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  has_many :orders
  belongs_to :room

  has_attached_file :avatar,
                    styles: { thumb: ["64x64#", :png]},
                    :storage => :cloudinary,
                    :path => ':id/:style/:filename',
                    :cloudinary_credentials => Rails.root.join("config/cloudinary.yml"),
                    :cloudinary_resource_type => :image,
                    :cloudinary_url_options => {
                        :default => {
                            :secure => true
                        }
                    }
  validates_attachment :avatar, presence: true,
                       content_type: {content_type: ["image/jpeg", "image/gif", "image/png"]},
                       size: { in: 0..500.kilobytes }
end
