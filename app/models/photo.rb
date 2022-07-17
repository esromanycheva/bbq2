class Photo < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :event, presence: true
  validates :user, presence: true

  has_one_attached :photo_image, service: :yandex do |photo|
    photo.variant :thumb, resize_to_limit: [200, 200]
    photo.variant :resize_to_fill, resize_to_limit: [400, 400]
  end

  scope :persisted, -> { where "id IS NOT NULL" }
end
