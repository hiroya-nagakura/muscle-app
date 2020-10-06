class TagGroup < ApplicationRecord
  has_many :tag, dependent: :destroy
end
