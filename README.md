# Community Library - Rails

### A Rails application for tracking books in your library, and sharing/borrowing books from others!

## Purpose

Just a French translation of the original project, with gem versions bumped up.

## Usage

To use this app, fork and clone this repo, run bundle install, run `rake db:migrate` and then run locally with `rails s -p 3000` (can access rails console with `rails c`). Create a user account and add as many books as you'd like. You can track your own book collection with this app, and/or use in conjunction with friends. The app allows you to mark some books as 'available' which means other users can request to borrow them. And users are able to borrow books others have marked as 'available', and return when done.

To track books you've enjoyed. Leave a comment when you borrow a book - these comments are always viewable from your homepage. These comments are visible to other users when they view the book you've commented on prior to borrowing, and visible to the book's owner.

## Contributing

Apart for cosmetic changes, it may be more usefull to contribute to the original project.

## License

The app is available as open source under the terms of the [MIT License](https://github.com/AutumnJ/AutumnJ-community-library-rails/blob/master/LICENSE.md).
