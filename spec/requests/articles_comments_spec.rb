require 'rails_helper'

RSpec.describe "Articles Comments" do
  describe "GET articles comments" do
    context 'when no user is signed in' do
      let(:comment) {create(:comment)}

      it 'shows articles comments' do
        get "/articles/#{comment.article.id}"

        expect(response).to have_http_status(:ok)
        expect(response.body).to include comment.body
      end
    end
  end

  
end
