require 'rails_helper'

RSpec.describe Appointment, type: :model do
  
  it { should belong_to(:consultancy) }

  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:time) }
  it { should validate_presence_of(:problem) }
end
