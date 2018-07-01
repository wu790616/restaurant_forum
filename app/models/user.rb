class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true
  mount_uploader :avatar, AvatarUploader

  # 使用者評論餐廳=>多對多關聯
  has_many :comments, dependent: :destroy
  has_many :restaurants, through: :comments
  
  # 使用者收藏餐廳=>多對多關聯
  has_many :favorites, dependent: :destroy
  has_many :favorited_restaurants, through: :favorites, source: :restaurant

  has_many :likes, dependent: :destroy
  has_many :liked_restaurants, through: :likes, source: :restaurant

  # 使用者有很多追蹤紀錄(followships), 透過追蹤紀錄，一個User追蹤很多其他User(followings)
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

  def admin?
    self.role == "admin"
  end

  def following?(user)
    self.followings.include?(user)
  end
end
