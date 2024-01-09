require 'rails_helper'

RSpec.describe 'Users', type: :system do 
  context 'when signing in' do 
    it 'goes to dashboard path with existing account' do 
    end
    it 'goes to edit username page with newly created accounts' do 
    end
  end
  context 'when signing up' do 
    it 'stays on same screen because of turbo frames' do 
    end
    it 'redirects to use name page with successful sign up' do 
    end
  end

end