class Tag < ApplicationRecord
  belongs_to :tag_group
  has_many :article_tags, dependent: :destroy
  has_many :articles, through: :article_tags

  validates :name, presence: true
end
