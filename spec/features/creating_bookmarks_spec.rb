feature 'Adding a new bookmark' do
  scenario 'A user can add a bookmark' do

    visit('/bookmarks')
    click_button('Add bookmark')

    fill_in('url', with: 'http://www.example.org')
    fill_in('title', with: 'Test Bookmark')
    click_button('Submit')

    expect(page).to have_link('Test Bookmark', href: 'http://www.example.org')
  end

  scenario 'A user adds an invalid url' do
    visit('/bookmarks/new')
    fill_in('url', with: 'not a real bookmark')
    fill_in('title', with: 'invalid url')
    click_button('Submit')

    expect(page).to_not have_content('invalid url')
    expect(page).to have_content("You must submit a valid URL.")
  end
end