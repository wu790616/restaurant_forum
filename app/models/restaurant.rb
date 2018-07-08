class Restaurant < ApplicationRecord
  validates_presence_of :name
  mount_uploader :image, PhotoUploader

  #排序
  default_scope { order(created_at: :desc)}

  belongs_to :category
  has_many :comments, dependent: :destroy
  
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user  

  def is_favorited?(user)
    self.favorited_users.include?(user)
  end

  def is_liked?(user)
    self.liked_users.include?(user)
  end

  def count_favorites
    self.favorites_count = self.favorites.size
    self.save
  end
end
