require 'rails_helper'

RSpec.describe Consultancy, type: :model do
  it { should have_many(:appointments).dependent(:destroy) }

  it { should validate_presence_of(:type) }
end
