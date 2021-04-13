class Consultancy < ApplicationRecord
  has_many :appointments

  validates_presence_of :type, :area
end
