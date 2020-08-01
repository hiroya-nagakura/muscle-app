class Article < ApplicationRecord
  belongs_to :user
  
  validates :title, :target_site, :body, presence: true
end
