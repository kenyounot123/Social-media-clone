require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  include Devise::Test::IntegrationHelpers
  include_context 'skip welcome email'
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user)}
  context 'when visiting dashboard page' do 
    it 'shows posts created by users who you follow' do
      sign_in user
      visit dashboard_path
    end
    it 'shows your own created posts' do 
    end
  end
end