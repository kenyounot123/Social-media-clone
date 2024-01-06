require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  include Devise::Test::IntegrationHelpers
  include_context 'skip welcome email'
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user)}
  context 'when visiting dashboard page' do 
    it 'shows posts created by users who you follow' do
      sign_in user
      other_user = create(:user)
      create(:post, user: other_user)
      user.follow(other_user)
      visit dashboard_path
      expect(page.has_content? "#{other_user.name} posted").to be true
    end
    it 'shows no posts if you follow no one and have not created posts' do 
      sign_in user
      visit dashboard_path
      expect(page.has_no_content?("posted")).to be true
    end

    it 'shows your own created posts' do 
      sign_in user
      create(:post, user: user)
      visit dashboard_path
      expect(page.has_content? "#{user.name} posted").to be true
    end
  end
end