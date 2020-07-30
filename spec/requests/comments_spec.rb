require 'rails_helper'

RSpec.describe "Comments" do
  let(:article) {create(:article)}
  let(:comment) {create(:comment, article: article)}

  describe "EDIT articles comments" do
    context 'when no user is signed in' do
      it 'redirects back to login path using patch' do
        patch_params = {
          params: {
            comment: {
              body: 'New body'
            }
          }
        }

        patch comment_path(comment), patch_params

        expect(response).to redirect_to(login_path)
      end
    end
  end
end