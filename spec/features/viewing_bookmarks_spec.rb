feature 'Viewing bookmarks' do
  scenario ' A user can see bookmarks' do
    Bookmark.create(url: 'http://www.makersacademy.com', title: 'Makers Academy2')
    Bookmark.create(url: 'http://www.codecademy.com', title: 'Codecademy2')
    Bookmark.create(url: 'http://wwww.udemy.com', title: 'Udemy2')

    visit('/bookmarks')

    expect(page).to have_content 'http://www.makersacademy.com'
    expect(page).to have_content 'http://www.codecademy.com'
    expect(page).to have_content 'http://wwww.udemy.com'
  end
end
