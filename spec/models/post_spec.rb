require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { should have_many(:comments).as(:commentable) }
    it { should belong_to(:user) }
    it { should have_many(:liking_users).through(:likes).source(:user) }
  end

  context 'when removing a post' do
    it 'should also remove the comments for that post' do
      post_with_comments = Post.create!(user_id: 1, title: 'hi', body: 'hello', id:5)
      post_with_comments.comments.create!(content: 'hi')
      post_with_comments.destroy
      expect(Comment.find_by(commentable_id: 5)).to be_nil
    end
  end
end
