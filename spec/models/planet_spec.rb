require 'rails_helper'

RSpec.describe Planet, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:planet)).to be_valid
  end

  describe '#name' do
    it 'should be invalid if empty' do
      expect(FactoryGirl.build(:planet, name: '')).to be_invalid
    end
  end
end
