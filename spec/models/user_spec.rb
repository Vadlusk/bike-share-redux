require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :username }
    it { should validate_uniqueness_of :username }
    it { should validate_presence_of :password }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }

    it 'should be created with default role' do
      user = create(:user)

      expect(user.default?).to be_truthy
    end
  end
end
