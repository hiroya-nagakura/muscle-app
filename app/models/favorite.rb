class Favorite < ApplicationRecord

  belong_to :user
  belong_to :article
  validates :user_id, presence: true
  validates :article_id, presence: true


end
