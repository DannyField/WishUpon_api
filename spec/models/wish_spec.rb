require 'rails_helper'

RSpec.describe Wish, type: :model do
  subject {build(:wish)}
  context 'validations' do
    it 'has a valid factory' do
      expect(build(:wish)).to be_valid
    end

    it { expect(subject).to validate_presence_of(:title)}

    it { expect(subject).to validate_length_of(:title).is_at_least(5).is_at_most(100)}

    it { expect(subject).to validate_presence_of(:description)}

    it { expect(subject).to validate_length_of(:description).is_at_least(10).is_at_most(600)}
 
  end

  context 'associations' do
    it {expect(subject).to belong_to(:user)}
  end
end
