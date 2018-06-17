class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true
  mount_uploader :avatar, AvatarUploader

  def admin?
    self.role == "admin"
  end

  has_many :comments
  has_many :restaurants, through: :comments
  
end
