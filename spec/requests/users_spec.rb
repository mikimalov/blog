require 'rails_helper'

RSpec.describe "Users" do
  it 'Creates a user and redirects to user when params are valid' do
    get '/users/signup'
    expect(response).to render_template(:new)

    post_params = {
      params: {
        user: {
          name: 'Mikii', email: 'mikimiki@gmail.com', password: 123456, password_confirmation: 123456
        }
      }
    }
    post '/users', post_params

    expect(session[:user_id]).not_to be nil
    expect(response).to redirect_to(assigns(:user))
    follow_redirect!

    expect(response).to render_template(:show)
    expect(response.body).to include("Mikii")
    expect(response.body).to include("mikimiki@gmail.com")
  end

  it 'renders template new when params are empty or invalid' do
    get '/users/signup'
    expect(response).to render_template(:new)

    post_params = {
      params: {
        user: {
          name: 'Mikii', email: '', password: 123, password_confirmation: 123456
        }
      }
    }
    post '/users', post_params

    expect(session[:user_id]).to be nil
    expect(response).to render_template(:new)
  end
end
