require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "POST /posts" do
    let(:user) { create(:user) }
    before(:each) do
      User.skip_callback(:create, :after, :send_welcome_email)
    end
    after(:each) do
      User.set_callback(:create, :after, :send_welcome_email)
    end
    before do
      default_url_options[:host] = 'localhost:3000' # Replace with your host and port
      sign_in user
    end
    it 'creates a new post from dashboard page' do
      get dashboard_path
      get new_post_path, as: :turbo_stream
      expect(response.body).to include('<turbo-frame id="new_post">')
      post_params = attributes_for(:post)
      expect {
        post posts_path, params: { post: post_params }, as: :turbo_stream
      }.to change { Post.count }.by(1)
      expect(response).to have_http_status(200)
    end
    it 'shows the new post in the dashboard created using turbo frames' do 
      post_params = attributes_for(:post)
      post posts_path, params: { post: post_params }, as: :turbo_stream
      post = Post.last
      expect(response.body).to include("<turbo-frame id=\"post_#{post.id}\">")
      expect(response).to have_http_status(200)
    end
  end
end
