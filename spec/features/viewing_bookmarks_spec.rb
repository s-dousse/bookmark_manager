feature 'Viewing bookmarks' do
  scenario ' A user can see bookmarks' do
    visit('/bookmarks')

    expect(page).to have_content 'http://www.makersacademy.com'
    expect(page).to have_content 'http://www.codecademy.com'
    expect(page).to have_content 'http://wwww.udemy.com'
  end
end
