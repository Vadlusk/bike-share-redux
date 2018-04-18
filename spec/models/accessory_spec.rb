require 'rails_helper'

describe Accessory do
  context 'Field validations' do
    context ''
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:price) }
    it { should validate_uniqueness_of(:title) }
    it { should validate_numericality_of(:price) }
  end
end
