require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when validating on edit' do 
    it 'is not valid with name greater than 25 characters' do
      user = User.new(name: 'qwerqwerqwerqweqwerqwer', email: 'test@example.com', password: 'somepassword')
      expect(user).to_not be_valid(:edit)
    end
    it 'is not valid with name less than 2 characters' do
      user = User.new(name: 'j', email: 'test@example.com', password: 'somepassword')
      expect(user).to_not be_valid(:edit)
    end
  end

  describe 'associations' do
    it { should have_many(:posts).class_name('Post') } 
    it { should have_many(:comments).class_name('Comment') } 
    it { should have_many(:passive_relationships).class_name('Relationship') } 
    it { should have_many(:active_relationships).class_name('Relationship') }
    it { should have_many(:liked_posts).through(:likes).source(:post) }
  end

  describe 'relationships' do 
    before(:each) do
      User.skip_callback(:create, :after, :send_welcome_email)
    end
    after(:each) do
      User.set_callback(:create, :after, :send_welcome_email)
    end
    let(:user) { User.create!(id: 1, name: 'Alice', email: 'alice@example.com', password: 'password' ) }
    let(:other_user) { User.create!(id: 2, name: 'michael', email: 'michael@example.com', password: 'password' ) }
    describe '#follow' do
      it 'creates an active relationship of a user following another user' do
        user.follow(other_user)
        expect(user.active_relationships.last.followed).to eq(other_user)
      end

      it 'correctly follows other user' do
        user.follow(other_user)
        expect(user.following?(other_user)).to eq(true)
      end
    end

    describe '#unfollow' do
      it 'destroys the active relationship' do
        user.active_relationships.create(follower_id: user.id, followed_id: other_user.id)
        user.unfollow(other_user)
        expect(user.active_relationships.find_by(followed_id: other_user.id, 
                                              follower_id: user.id)).to be_nil
      end
      it 'correctly unfollows the other user' do 
        user.follow(other_user)
        user.unfollow(other_user)
        expect(user.following?(other_user)).to eq(false)
      end
    end

    describe '#following?' do
      context 'when user is following the other user' do
        it 'returns true' do 
          user.follow(other_user)
          expect(user.following?(other_user)).to eq(true)
        end
      end
      context 'when user is not following the other user' do
        it 'returns false' do 
          expect(user.following?(other_user)).to eq(false)
        end
      end
    end
  end
end
