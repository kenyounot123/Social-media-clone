require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:each) do
    User.skip_callback(:create, :after, :send_welcome_email)
  end
  after(:each) do
    User.set_callback(:create, :after, :send_welcome_email)
  end
  describe 'associations' do
    it { should have_many(:comments) }
    it { should belong_to(:user) }
    it { should have_many(:liking_users).through(:likes).source(:user) }
  end

  context 'when removing a post with comments' do
    it 'should also remove the comments for that post' do
      post = create(:post, user: create(:user, id: 2, email: 'newemail@example.com'))
      post.destroy
      expect(Comment.find_by(commentable_id: 5)).to be_nil
    end
  end
end
