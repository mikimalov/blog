require 'rails_helper'

RSpec.describe User do

  context "when saving" do
    it "transforms email to downcase" do
      john = create(:user, email: 'TESTING@TEST.com')
      expect(john.email).to eq 'testing@test.com'
    end
  end

  describe "validations " do

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to have_secure_password }
    it { is_expected.to validate_length_of(:password).is_at_least(User::MINIMUM_PASSWORD_LENGTH)}
    it { is_expected.to validate_length_of(:name).is_at_most(User::MAXIMUM_NAME_LENGTH) }
    it { is_expected.to validate_length_of(:email).is_at_most(User::MAXIMUM_EMAIL_LENGTH) }
    it { is_expected.to have_many(:articles)}
    it { is_expected.to have_many(:comments)}

    it 'matches uniqueness of email' do
      expect(create(:user)).to validate_uniqueness_of(:email)
    end

    context 'when using invalid email format' do
      it 'si invalid' do
        john = build(:user, email: 'TESTING@INVALID')
        expect(john.valid?).to be false
      end
    end

    # context 'when name is not present' do
    #   it 'is invalid' do
    #     john = build(:user, name: nil)
    #     expect(john.valid?).to be false
    #   end
    # end

    # context 'when email is not present' do
    #   it 'is invalid' do
    #     john = build(:user, email: nil)
    #     expect(john.valid?).to be false
    #   end
    # end

    # context 'when password is not present' do
    #   it 'is invalid' do
    #     john = build(:user, password: nil)
    #     expect(john.valid?).to be false
    #   end
    # end

    # context 'when password confirmation does not match password' do
    #   it 'is invalid' do
    #     john = build(:user, password: '123456', password_confirmation: '')
    #     expect(john.valid?).to be false
    #   end
    # end
  end
end
