# bookmark_manager

solo quest to review key concepts of DB and ORM

specifications :

- Show a list of bookmarks
- Add new bookmarks
- Delete bookmarks
- Update bookmarks
- Comment on bookmarks
- Tag bookmarks into categories
- Filter bookmarks by tag
- Users are restricted to manage only their own bookmarks

## feature 1 : Viewing bookmarks

user story 1

```
As a time-pressed user
So that I can quickly go to web sites I regularly visit
I would like to see a list of bookmarks
```

steps:

- [x] Write a failing feature test for viewing bookmarks at the `/bookmarks` route.
- [x] Pass the feature test in the simplest way possible.
- [x] Refactor the code to use the View and Controller.
- [x] Test drive a refactor of the code to use a Model, that returns the list of bookmarks.

## DB setup

- create 2 db with psql
  one for development `CREATE DATABASE bookmark_manager;`
  one for test `CREATE DATABASE bookmark_manager_test;`
- use queries from db/migrations

## Wrapping DB data into Program Objects

- add tittle value to the table (see db/migrations)
- add feature test to check the title is diplayed on webpage
- update the View and the Controller
- update the Model to use the given values : store them in the DB, extract them to be wrapped into Ruby objects
- update all the unit tests

## Securing our App
OWASP Top Ten: https://owasp.org/www-project-top-ten/
- finding the vunerability: in our model the user'input is collected via the  new bookmark form and inserted into an SQL query string template
- if the right snippet of SQL is inserted into one of the two form fields, that SQL string would be executed (DROP TABLE etc)
- make changes to defend against SQL injection
'https://www.rubydoc.info/gems/pg/PG%2FConnection:exec_params'

## feature 2 : Deleting bookmarks
user story 2
```
As a user
So I can remove my bookmark from Bookmark Manager
I want to delete a bookmark.
```

- write Capybara test based on user's flow:
    a) Visit the bookmarks page
    b) Click a 'delete' button next to a bookmark
    c) See the bookmarks page, without that bookmark
- We need to build a route for our Delete button to submit to, in app.rb, and enable :method_override => use DELETE method

