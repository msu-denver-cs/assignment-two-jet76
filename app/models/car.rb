class Car < ApplicationRecord
  belongs_to :make
  has_and_belongs_to_many :parts
  validates :make, presence: true # validate make is present
  validates :model, presence: true # validate model is present
  validates :vin, uniqueness: true, presence: true, format: {with: /\A[A-Z0-9]*\z/, message: "may only contain A-Z and 0-9"} # validate vin
  validates_associated :parts # validate parts exist
  validates :parts, presence: true # validate parts are present
end
