require 'rails_helper'

describe Order, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:user_id)}
  end
end
