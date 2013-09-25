class Photo < ActiveRecord::Base
  validates :file, presence: true
  mount_uploader :file, PhotoUploader

  default_scope -> { order(updated_at: :desc) }
end
