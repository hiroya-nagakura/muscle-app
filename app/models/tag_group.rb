class TagGroup < ApplicationRecord
  has_many :tags, dependent: :destroy
end
