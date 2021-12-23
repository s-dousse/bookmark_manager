feature 'Deleting a bookmark' do
  scenario 'A user can delete a bookmarks' do
  # set up test data
  bookmark =Bookmark.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')

  # checking the test is present
  visit('/bookmarks')
  expect(page).to have_link('Makers Academy')

  # carrying out the DELETE action
  # Capybara's first method to click the Delete button inside the first element with class 'bookmark'
  # => add the bookmark class to the HTML list item
  first('.bookmark').click_button('Delete')

  # checking the data has been removed
  # expect(current_path).to eq "/bookmarks/#{bookmark.id}"
  expect(page).not_to have_link('Makers Academy')
  end
end
