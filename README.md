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
- use query from 01_create_bookmarks_table.sql to create the table for both db
