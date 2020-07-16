require 'rails_helper'

RSpec.describe UserHobby, type: :model do
  context 'validations' do
    it 'has a valid factory' do
      expect(build(:user_hobby)).to be_valid
    end
  end

  context 'associations' do
    it { expect(subject).to belong_to(:user)}
    it { expect(subject).to belong_to(:hobby)}
  end
end
