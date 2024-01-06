require 'rails_helper'

RSpec.describe Post, type: :model do
  include_context 'skip welcome email'
  describe 'associations' do
    it { should have_many(:comments) }
    it { should belong_to(:user) }
    it { should have_many(:liking_users).through(:likes).source(:user) }
  end

  context 'when removing a post with comments' do
    it 'should also remove the comments' do
      post = create(:post)
      create_list(:post_comment, 5, commentable: post)
      expect { post.destroy }.to change { post.comments.count }.by(-5)
    end
  end
  describe 'Post behavior' do 
    let(:user) { create(:user) }
    let(:post) { create(:post) }
    describe '#liked_by?' do  
      it 'returns true if post is liked by the given user' do 
        post.like(user)
        expect(post.liked_by?(user)).to eq(true)
      end
      it 'returns false if post is not liked by the given user' do
        post.like(user)
        post.unlike(user)
        expect(post.liked_by?(user)).to eq(false)
      end
    end

    describe '#unlike' do 
      it 'removes like from post given by a particular user' do
        post.like(user)
        expect { post.unlike(user) }.to change { post.likes.count }.by(-1)
      end
    end

    describe '#like' do 
      it 'generates a like given by a particular user for the post' do
        expect { post.like(user) }.to change { post.likes.count }.by(1)
      end
    end
  end

  
end
