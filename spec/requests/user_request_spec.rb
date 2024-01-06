require 'rails_helper'

RSpec.describe "Users", type: :request do 
  include_context 'skip welcome email'
  context 'when going to user profiles' do
    let(:user) { create(:user) }
    let!(:post) { create_list(:post, 3, user: user) }
    before do 
      sign_in user
    end
    it "should properly redirect to user profiles from user index page" do
      get dashboard_path
      get user_path(user)
      expect(response.body).to include("All of #{user.name}'s recent posts")
    end
    it "should properly redirect to user profiles from another user profile" do
      other_user = create(:user, name: 'another user')
      get user_path(user)
      get user_path(other_user)
      expect(response.body).to include("All of #{other_user.name}'s recent posts") 
    end
  end
end