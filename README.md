# Ruby on Rails interview problem set

## Setup
Clone the setup code for the problems from github using
`git clone git@github.com:ditsara/glazziq-interview.git`. Setup the SQLite3 database with `rake db:migrate` and `rake db:seed`.

## Background

This Rails application is intended to be a multi-user messageboard. Users will be able to sign up from the internet and create posts. Users will be able to view (but not edit) other users' posts. The code is currently a bare scaffold with two models: `User` and `Post`. For this exercise, you will be implementing various features, but will not actually be completing the application in any meaningful way.

*User Interface*: Note that some problems will require you to output data to a web page and provide form elements for input. We are interested that the correct information is presented on the page, but we don't care about the styling of that information. You should not have to write any SCSS or CSS code.

*Gems*: You are not allowed to change the Gemfile or import gems into `./vendor`. We are testing your coding and design skills, not your ability to research and find existing solutions. Feel free to read code from any publicly available sources and use the same concepts in your own implementation.

*Tests*: Test are not required, but you may use them to ensure your implementation is correct. You may import gems for test frameworks or test tools (such as `rspec`, `factory_girl`, `capybara`, etc). This is the only exception to the rule about changing the Gemfile.

*Comments and General Notes*: There are many ways to solve the problems below (including many naive / trivial solutions). You should include comments in the code that another developer would expect to see if they were working with you on the system. If you want to pass any general notes about your architecture or approach, you can modify `README.md`.

## Problems

1. Posts can currently be created with any user id (even invalid ones). Change this so posts can only be created by the current user. Ensure all posts are associated with a valid user. For now, skip implementation of user sign-in and get the (simulated) current user with `current_user` (see `ApplicationController`). Users should be able to see a list of their own posts and edit posts that they previously created. You can create new users in `seeds.rb` and "log them in" by passing `set_user=[user id]` in the url.
2. Build a post tagging system. Tags consist of only a name. A tag can be created by any user, but may not be changed or destroyed once created. A post can have any number of tags, and a tag can be applied to any post. Only the post author may attach to or remove tags from their post. When viewing a post, a user can see its associated tags. In addition, users can click on a tag to view a list of the posts associated with it.
3. (Optional) Create a topic system. Like tags, topics consist of only a name. Unlike tags, topics are owned by a user, and can only be attached to or removed from a post by the topic's owner. A user can create (and thus own) many topics. On `posts#index`, display a list of tags and topics associated with each post.
