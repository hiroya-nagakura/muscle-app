class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  attr_accessor :current_password
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :image, ImageUploader
  has_many :articles, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_articles, through: :favorites, source: :article
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :user
  has_many :comments, dependent: :destroy
  has_many :records, dependent: :destroy
  has_many :bodyweights, dependent: :destroy

  validates :user_name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, length: { maximum: 255}

  # いいねしているかどうかの確認
  def already_favorite?(article)
    favorites.exists?(article_id: article.id)
  end

  # フォローする
  def follow(other_user)
    relationships.find_or_create_by(follow_id: other_user.id) unless self == other_user
  end

  # フォローを解除する
  def unfollow(other_user)
    relationship = relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship.present?
  end

  # フォローしているかどうかの確認
  def following?(other_user)
    followings.include?(other_user)
  end

  # ゲストログイン用設定
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.user_name = 'ゲストユーザー'
    end
  end
end
