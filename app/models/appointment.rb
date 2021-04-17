class Appointment < ApplicationRecord
  belongs_to :consultancy
  belongs_to :user
  validates_presence_of :time, :problem
end
