class Photo < ActiveRecord::Base
  validates :file, presence: true
  mount_uploader :file, PhotoUploader
end
