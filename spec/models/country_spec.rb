require 'rails_helper'

RSpec.describe Country, type: :model do
  subject {build(:country)}
  context 'validations' do
    it 'has a valid factory' do
      expect(build(:country)).to be_valid
    end

    it { expect(subject).to validate_presence_of(:name)}
  end

  context 'associations' do
    it { expect(subject).to have_many(:users) }
  end
end
