require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  context 'validations' do
    it 'has a valid factory' do
      expect(build(:user)).to be_valid
    end

    it { expect(subject).to validate_presence_of(:email) }
    it { expect(subject).to validate_uniqueness_of(:email) }
    it { expect(subject).to have_secure_password }
  end

  context 'associations' do
    it { expect(subject).to have_many(:wishes) }
    it { expect(subject).to have_many(:hobbies) }
    it { expect(subject).to belong_to(:country)}
  end
end
