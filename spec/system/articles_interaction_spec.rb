require 'rails_helper'

RSpec.describe "ArticlesInteraction" do
  let(:user) {create(:user)}
  let(:article) {create(:article, user: user)}

  before do
    driven_by :rack_test
    log_in(user)
  end

  describe 'Creating an article' do
    it 'creates and shows the newly created article' do
     title = 'Create new sistem spec'
     body = 'This is the body'

      click_on "New Article"

      within('form') do
        fill_in "Title", with: title
        fill_in "Body", with: body

        click_on "Submit"
      end

      expect(page).to have_content(title)
      expect(page).to have_content(body)
    end
  end

  describe 'Editing an article' do
    it 'edits and shows the article' do
      title = 'New title'
      body = 'This is new body'

      visit article_path(article)
      click_on 'Edit'

      within('form') do
        fill_in "Title", with: title
        fill_in "Body", with: body

        click_on "Submit"
      end

      expect(page).to have_content(title)
      expect(page).to have_content(body)
    end
  end

  describe 'Deleting an article' do
    it 'deletes the article' do
      visit article_path(article)
      #only if using rack_test driver
      click_on 'Delete'

      #Only if using selenium driver
      #accept_alert do
        #click_on 'Delete'
      #end

      expect(page).to have_content('Articles')
    end
  end

  describe 'Creating new article comments' do
    it 'creates an article comment' do
      visit article_path(article)

      click_on 'New Comment'
      within('form') do
        fill_in "comment_body", with: 'New comment'

        click_on "Save"
      end

      expect(page).to have_content('New comment')
    end
  end

  describe 'Going back to article index page' do
    it '' do
      visit article_path(article)

      click_on 'Back'

      expect(page).to have_content('Articles')
    end
  end
end