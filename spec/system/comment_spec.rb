require 'rails_helper'

RSpec.describe 'Comments', type: :system do
  include Devise::Test::IntegrationHelpers
  include_context 'skip welcome email'
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }
  before do 
    sign_in user
    post
  end
  context 'when commenting on a post' do 
    it 'properly shows the comments under the specified post' do
      visit dashboard_path
      click_link 'Comment'
      fill_in 'comment[content]', with: "Random comment"
      click_button 'Create Comment'
      expect(page.has_content? "#{user.name} commented: Random comment").to be true
    end
    it 'does not do anything when content is empty' do 
      visit dashboard_path
      click_link 'Comment'
      fill_in 'comment[content]', with: ""
      click_button 'Create Comment'
      expect(page).to have_current_path(post_path(post))
      expect(page).not_to have_content("#{user.name} commented:")
    end
  end
  context 'when commenting on a comment' do 
    it 'properly shows the reply under the comment' do 
      visit dashboard_path
      click_link 'Comment'
      fill_in 'comment[content]', with: "Random comment"
      click_button 'Create Comment'
      click_link 'Reply'
      fill_in 'comment_content', with: "Random reply"
      click_button 'Reply'
      expect(page.has_content? "#{user.name} replied: Random reply").to be true
    end
    it 'does not do anything when content is empty' do 
      visit dashboard_path
      click_link 'Comment'
      fill_in 'comment[content]', with: "Random comment"
      click_button 'Create Comment'
      click_link 'Reply'
      fill_in 'comment_content', with: ""
      click_button 'Reply'
      expect(page).to have_current_path(post_path(post))
      expect(page).not_to have_content("#{user.name} replied: Random reply")
    end
    it 'redirects back to dashboard page when failing to reply from dashboard page' do 
      visit dashboard_path
      click_link 'Comment'
      fill_in 'comment[content]', with: "Random comment"
      click_button 'Create Comment'
      visit dashboard_path
      click_link 'Reply'
      fill_in 'comment_content', with: ""
      click_button 'Reply'
      expect(page).to have_current_path(dashboard_path)
      expect(page).not_to have_content("#{user.name} replied: Random reply")
    end
  end
end