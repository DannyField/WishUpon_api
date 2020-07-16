require 'rails_helper'

RSpec.describe WishKeyword, type: :model do
  context 'validations' do
    it 'has a valid factory' do
      expect(build(:wish_keyword)).to be_valid
    end
  end

  context 'associations' do
    it { expect(subject).to belong_to(:wish)}
    it { expect(subject).to belong_to(:keyword)}
  end
end
