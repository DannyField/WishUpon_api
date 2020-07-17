require 'rails_helper'

RSpec.describe Hobby, type: :model do
  subject {build(:hobby)}
  context 'validations' do
    it 'has a valid factory' do
      expect(build(:hobby)).to be_valid
    end

    it { expect(subject).to validate_presence_of(:name)}

    it { expect(subject).to validate_length_of(:name).is_at_least(2).is_at_most(30)}
  end

  context 'association' do
    it { expect(subject).to have_many(:users).through(:user_hobbies)}
  end
end
