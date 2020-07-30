require 'rails_helper'

RSpec.describe "Articles" do
  describe 'editing an article' do
    context "when no user is logged in" do
      it '' do
        post_params = {
          params: {
            article: {
              title: 'New article'
            }
          }
        }

        post '/articles', post_params

        expect(response).to redirect_to(login_path)
        expect(flash[:danger]).to eq "Please sign in to continue."
      end
    end
  end
  describe 'editing an article' do
    context 'when user is logged in' do
      let(:user) {create(:user)}
      let(:article) {create(:article, user: user)}

      let(:login_user) {create(:user)}

      it 'can edit the article' do
        get '/login'
        expect(response).to have_http_status(:ok)

        post_params = {
          params: {
            session: {
              email: user.email,
              password: user.password
            }
          }
        }

        post '/login', post_params

        follow_redirect!
        # expect(flash[:success]).to eq "Welcome #{user.name} !"

        get "/articles/#{article.id}"
        expect(response).to have_http_status(:ok)

        get "/articles/#{article.id}/edit"
        expect(response).to have_http_status(:ok)

        patch_params = {
          params: {
            article: {
              title: article.title,
              body: "New Body"
            }
          }
        }

        patch "/articles/#{article.id}", patch_params

        expect(response).to have_http_status(:found)

        expect(response).to redirect_to(assigns(:article))
        follow_redirect!

        expect(response.body).to include(article.title)
      end
    end
  end

  context "when the article's user is different then the logged in User" do
    let(:user) { create(:user) }
    let(:article) { create(:article, user: user) }

    let(:login_user) { create(:user) }

    it 'redirects back to root path' do
      get '/login'

      post_params = {
        params: {
          session: {
            email: login_user.email,
            password: login_user.password
          }
        }
      }

      post '/login', post_params

      get "/articles/#{article.id}/edit"

      expect(flash[:danger]).to eq "Wrong user!"
      expect(response).to redirect_to(root_path)
    end
  end

  context "when no user is logged in" do
    let(:article) { create(:article) }

    it 'redirect back to login path' do
      get "/articles/#{article.id}/edit"

      expect(flash[:danger]).to eq "Please sign in to continue."
      expect(response).to redirect_to(login_path)
    end

    it 'redirects back to login when updating' do
      patch_params = {
        params: {
          article: {
            title: article.title,
            body: "New Body"
          }
        }
      }

      patch "/articles/#{article.id}", patch_params

      expect(flash[:danger]).to eq "Please sign in to continue."
      expect(response).to redirect_to(login_path)
    end

  end

  describe 'Deleting an article' do
    context "when the article's user is the same as the logged in User" do
      let(:user) { create(:user) }
      let(:article) { create(:article, user: user) }

      it 'can delete the article' do
        get '/login'

        post_params = {
          params: {
            session: {
              email: user.email,
              password: user.password
            }
          }
        }

        post '/login', post_params

        follow_redirect!

        delete "/articles/#{article.id}"

        expect(response).to redirect_to(articles_path)
      end
    end

    context "when the article's user is different then the logged in User" do
      let(:user) { create(:user) }
      let(:article) { create(:article, user: user) }

      let(:login_user) { create(:user) }

      it 'redirect back to root path' do
        get '/login'

        post_params = {
          params: {
            session: {
              email: login_user.email,
              password: login_user.password
            }
          }
        }

        post '/login', post_params

        follow_redirect!

        delete "/articles/#{article.id}"

        expect(flash[:danger]).to eq 'Wrong user!'
        expect(response).to redirect_to(root_path)
      end
    end

    context "when no user is logged in" do
      let(:article) { create(:article) }

      it 'redirect back to login path' do
        delete "/articles/#{article.id}"

        expect(flash[:danger]).to eq "Please sign in to continue."
        expect(response).to redirect_to(login_path)
      end
    end
  end
end