require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  include Devise::Test::IntegrationHelpers
  include_context 'skip welcome email'
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user)}
  before do 
    sign_in user
  end
  context 'when visiting dashboard page' do 
    it 'shows posts created by users who you follow' do
      other_user = create(:user)
      create(:post, user: other_user)
      user.follow(other_user)
      visit dashboard_path
      expect(page.has_content? "#{other_user.name} posted").to be true
    end
    it 'shows no posts if you follow no one and have not created posts' do 
      visit dashboard_path
      expect(page.has_no_content?("posted")).to be true
    end

    it 'shows your own created posts' do 
      post
      visit dashboard_path
      expect(page.has_content? "#{user.name} posted").to be true
    end
  end
  context 'comments' do 
    it 'redirects to post with comment form when clicking on comment link' do  
      post
      visit dashboard_path 
      click_link('Comment')
      expect(page.has_field?("comment_content")).to be true
      expect(page.has_button?("Create Comment")).to be true
    end
  end
end