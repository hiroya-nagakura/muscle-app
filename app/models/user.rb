class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :image, ImageUploader
  has_many :articles, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def already_favorite?(article)
    self.favorites.exists?(article_id: article.id)
  end

end
