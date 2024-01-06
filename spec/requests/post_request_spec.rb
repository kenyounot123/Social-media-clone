require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "POST /posts" do
    include_context 'skip welcome email'
    let(:user) { create(:user) }
    before do
      default_url_options[:host] = 'localhost:3000' # Replace with your host and port
      sign_in user
    end
    context 'creating posts' do 
      it 'creates a new post from dashboard page' do
        get dashboard_path
        get new_post_path, as: :turbo_stream
        expect(response.body).to include('<turbo-frame id="new_post">')
        post_params = attributes_for(:post)
        expect {
          post posts_path, params: { post: post_params }, as: :turbo_stream
        }.to change { Post.count }.by(1)
      end
      it 'shows the new post in the dashboard created using turbo frames' do 
        post_params = attributes_for(:post)
        post posts_path, params: { post: post_params }, as: :turbo_stream
        post = Post.last
        expect(response.body).to include("<turbo-frame id=\"post_#{post.id}\">")
      end
    end
    context 'deleting posts' do 
      it 'removes post from dashboard page' do
        post_params = attributes_for(:post)
        post posts_path, params: { post: post_params }, as: :turbo_stream
        post_id = Post.last.id
        delete posts_path, as: :turbo_stream
        expect(response.body).not_to include("<turbo-frame id=\"post_#{post_id}\">")
      end
    end
  end
end
