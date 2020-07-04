require 'rails_helper'

RSpec.describe Article do
  describe 'validations' do
    it { is_expected.to have_many(:comments)}
    it { is_expected.to belong_to(:user)}
  end

  describe "associations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_least(Article::MINIMUM_PASSWORD_LENGTH)}

    describe "dependency" do
      let(:comments_count) { 4 }
      let(:article) { create(:article) }

      it "destroy comments" do
        create_list(:comment, comments_count, article: article)
        expect {article.destroy}.to change {Comment.count}.by(-comments_count)
      end
    end
  end
end
