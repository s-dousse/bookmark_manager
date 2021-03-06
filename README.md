# bookmark_manager

solo quest to review key concepts such as:

- Agile and TDD
- Engineering and 'Dev Recipes'
- Databases
- Tooling

specifications :

- Show a list of bookmarks
- Add new bookmarks
- Delete bookmarks
- Update bookmarks
- Comment on bookmarks
- Tag bookmarks into categories
- Filter bookmarks by tag
- Users are restricted to manage only their own bookmarks

## feature 1 : Adding & Viewing bookmarks

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

- finding the vunerability: in our model the user'input is collected via the new bookmark form and inserted into an SQL query string template
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
  1. Visit the bookmarks page
  2. Click a 'delete' button next to a bookmark
  3. See the bookmarks page, without that bookmark
- We need to build a route for our Delete button to submit to, in app.rb, and enable :method_override => use DELETE method

## feature 3 : Update bookmarks

user story 3

```
As a user
So I can change a bookmark in Bookmark Manager
I want to update a bookmark
```

- [x] : write feature test
- [x] : update view and controller
- [x] : TDD for model
- [x] : update controller

add a feature to see just one bookmark before updating it: #find (use the bookmark's id)

## extracting a Database setup object

- Separate application behaviour from database behaviour
- Wrap an adaptor object

## feature 4: validating bookmarks

user story 4

```
As a user
So that the bookmarks I save are useful
I want to only save a valid URL
```

Validate user input in the model layer:
https://github.com/SFEley/sinatra-flash

- Adding a feature test for an invalid URL
- Adding Sinatra-Flash to show a message, passing this test
- Refactoring the validation logic into the Bookmark model

## feature 5 : comment on bookmarks

user story 5

```
As a user
So that I can make interesting notes
I want to add a Comment to a Bookmark
```

One bookmark can have many comments
One-to-many Relations: https://www.databaseprimer.com/pages/relationship_1tox/

We will have a column with the bookmark_id (id from bookmarks table) in our comments table.

### new table to store comments data

1. create new table: comments
2. add to db/migration
3. update setup_test_database and database_helpers

Viewing comments:

- add feature test
- update view index.erb => form 'Add comment'
- update controller => get route to display the form using the bookmark's id (comment/new.erb)
- create a view to display the comment form (comments/new.erb)
- update the controller => post route to store the data and turn it into a comment
- update view index.erb => display comment for each bookmark (bookmark.comments)

We need the Bookmark instance to respond to the comments method, and return an array of comments.

- create a unit test for a #comments method
- update model (Bookmark class): direct connection to the db to retrieve comments data entries
- update controller: post route 'bookmarks/:id/comments'

We create a Comment class that handles the creation of comments.

- create unit test for a .create method
- update model (Comment class)
- update model (Bookmark class) with Comment.create instead of connection to db (+ spec)
- create unit test for a .where method
- update model (Comment class)
- update view bookmarks/index.erb : iterate over the array given by bookmark.comments and display the comment as text

## feature 6: Tag bookmarks into categories

join table for Tags and Bookmarks (many to many relationship)

- one 'sibling' model, Bookmark, belongs to and has many Tags
- the other 'sibling' model, Tag, belongs to and has many Bookmarks
- the join table belongs to Bookmark and belongs to Tag

https://stackoverflow.com/questions/7296846/how-to-implement-one-to-one-one-to-many-and-many-to-many-relationships-while-de

https://dzone.com/articles/how-to-handle-a-many-to-many-relationship-in-datab

### new table to store tags data

1. create new table: tags and bookmarks_tag (join table)
2. add to db/migration
3. update setup_test_database

Adding and Viewing Tags:
- feature test
- add routes to create tags
- add form to view
- TDD Tags and BookmarksTags models
- add a #tag method to the Bookmark instances

## feature 7: Filter bookmarks by tag
