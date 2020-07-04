require 'rails_helper'

RSpec.describe Comment do
  describe 'validations' do
    it { is_expected.to belong_to(:article)}
    it { is_expected.to belong_to(:user)}
  end

  describe "associations" do
    it { is_expected.to validate_presence_of(:body) }
  end
end
