class Image < ApplicationRecord
  belongs_to :hotel
  validates :hotel_id, uniqueness: { scope: [:image_type, :link], message: "must be unique" }
end
