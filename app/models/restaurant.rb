class Restaurant < ApplicationRecord
  validates_presence_of :name
  mount_uploader :image, PhotoUploader
  belongs_to :category
  has_many :comments, dependent: :destroy
  default_scope { order(created_at: :desc)}
end
