require 'rails_helper'

RSpec.describe 'create bookmark', type: :system do
  scenario 'empty title and url' do
    visit new_bookmark_path
    click_button 'Create Bookmark'

    # The page should show error message 'Title can't be blank'
    # 'page' is a special variable from capybara, which contain information of the current displayed page
    expect(page).to have_content("Title can't be blank")

    # No bookmark record is created
    expect(Bookmark.count).to eq(0)
  end
end