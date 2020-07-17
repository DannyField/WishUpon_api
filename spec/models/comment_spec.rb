require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject {build(:comment)}
  context 'validations' do
    it 'has a valid factory' do
      expect(build(:comment)).to be_valid
    end

    it { expect(subject).to validate_presence_of(:content)}

    it { expect(subject).to validate_length_of(:content).is_at_least(5).is_at_most(300)}
  end

  context 'associations' do
    it { expect(subject).to belong_to(:wish)}
    it { expect(subject).to belong_to(:user)}
  end

end
