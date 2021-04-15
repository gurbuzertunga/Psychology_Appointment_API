class Appointment < ApplicationRecord
  belongs_to :consultancy
  validates_presence_of :time, :problem
end
