class Appointment < ApplicationRecord
  belongs_to :consultancies
  validates_presence_of :date, :time, :problem
end
