class Hotel < ApplicationRecord
  has_one :location, dependent: :destroy
  has_many :amenities, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :booking_conditions, dependent: :destroy

  accepts_nested_attributes_for :location, :amenities, :images, :booking_conditions
end
