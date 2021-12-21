feature 'Adding a new bookmark' do
  scenario 'A user can add a bookmark' do

    visit('/bookmarks')
    click_button('Add bookmark')

    fill_in('url', with: 'http://www.example.org')
    fill_in('title', with: 'Test Bookmark')
    click_button('Submit')

    expect(page).to have_link('Test Bookmark', href: 'http://www.example.org')
  end
end