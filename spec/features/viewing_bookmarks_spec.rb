feature 'Viewing bookmarks' do
  scenario ' A user can see bookmarks' do
    visit('/bookmarks')

    expect(page).to have_content "www.makersacademy."
    expect(page).to have_content "www.codecademy.com"
    expect(page).to have_content "wwww.udemy.com"
  end
end