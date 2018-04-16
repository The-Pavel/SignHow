class Gif < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :language, presence: true
  validates :file, presence: true
end
