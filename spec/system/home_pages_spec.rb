require 'rails_helper'

RSpec.describe "HomePages" do
  before do
    driven_by :rack_test
    visit root_path
  end

  it 'show the home link' do
    # take_screenshot
    expect(page.has_link?('My Blog')).to be true
  end

  context 'when no user is logged in' do
    it 'show the login link' do
      expect(page.has_link?('Log In')).to be true
    end

    it 'show the signup link' do
      expect(page.has_link?('Sign Up')).to be true
    end
  end

  context 'when current user is logged in' do
    before do
     log_in(create(:user))
      visit root_path
    end

    it 'shows the logout link' do
      expected = page.has_link?('Log Out')

      expect(expected).to be true
    end

    it 'shows the New Article link' do
      expected = page.has_link?('New Article')

      expect(expected).to be true
    end
  end

  context 'when an article is present' do
    let!(:article) { create(:article, title: 'Testing title with Rspec', body: 'Testing body with Rspec') }

    before do
      visit root_path
    end

    it 'shows the article title' do
      expecting = page.has_content?(article.title)

      expect(expecting).to be true
    end

    it 'shows the article body' do
      expecting = page.has_content?(article.body)

      expect(expecting).to be true
    end

    it 'has link Show' do
      expecting = page.has_link?('Show')

      expect(expecting).to be true
    end
  end
end
