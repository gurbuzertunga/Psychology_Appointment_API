require 'rails_helper'

RSpec.describe Consultancy, type: :model do
  it { should have_many(:appointments) }

  it { should validate_presence_of(:area) }
end
