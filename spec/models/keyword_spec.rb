require 'rails_helper'

RSpec.describe Keyword, type: :model do
    subject {build(:keyword)}
  context 'validations' do
    it 'has a valid factory' do
      expect(build(:keyword)).to be_valid
    end

    it { expect(subject).to validate_presence_of(:word)}

    it { expect(subject).to validate_length_of(:word).is_at_least(2).is_at_most(20)}
  end

  context 'association' do
    it { expect(subject).to have_many(:wishes).through(:wish_keywords)}
  end
end
