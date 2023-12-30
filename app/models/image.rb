# frozen_string_literal: true

class Image < ApplicationRecord
  belongs_to :hotel
  validates :hotel_id, uniqueness: { scope: %i[image_type link], message: 'must be unique' }
end
