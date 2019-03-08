------------------------------------------------------------------------------------
# Calie and Manu: Superhero Card Collection

For our Module 1 project, we have built a card collecting game in the style of the classic Panini sticker album.
Players can view cards for each individual superhero to see their stats and then add these cards to, or delete them from, their own collection

Seed data courtesy of https://www.superheroapi.com/

## Install instructions

Fork and clone this repository.
In the terminal, cd to main folder and type 'bash bin/setup.sh'

### User stories:

1. User can enter their name (process creates a new collection, or retrieves an existing one)
2. User can select a superhero and view their stats
3. User can add cards to their collection (select one, or receive 5 random)
4. User can delete cards from their collection
5. User can see how many cards they have in their collection
6. User can see how many cards they still need to collect
7. User can see a leaderboard showing which users have the most cards

### What did we learn???

- It's good to dream big but maybe not in mod1 project week!  We had a goal in mind but after the first day it was obvious we'd need to scale back our plans a little.
- It is easy to get carried away.  See above!  We split tasks which wasn't a great idea on day 1.  Day 2 we stopped to think, and began pairing properly.  Because we were focussed on doing one thing at a time we actually achieved more, and what we wrote, worked.
- Stop to think about how (and why) you are doing something - we spent ages writing a menu, then discovered a gem which would have done a lot of the hard work for us.
- To quote RailsGuides: "All of the association methods are built around caching, which keeps the result of the most recent query available for further operations. The cache is even shared across methods."
We found out about this because after deleting a card, it was still showing in our card count.  After a bit of research we fixed this by calling the reload method on that association.

### Stretch goals (ideas for the future)

1. Return a list of which character has the highest score for a particular attribute
2. Compare your collection to that of another user
3. Make some cards 'special' so they are more difficult to collect
4. Easter eggs for completing a set of characters (eg. all of the Avengers or all of the Justice League)
5. Add other categories of cards (eg sports, cars, animals etc)
6. Build a full-on Top Trumps style game!



---------------------------------------------------------------------------------------

# Module One Final Project Guidelines

Congratulations, you're at the end of module one! You've worked crazy hard to get here and have learned a ton.

For your final project, we'll be building a Command Line database application.

## Project Requirements

### Option One - Data Analytics Project

1. Access a Sqlite3 Database using ActiveRecord.
2. You should have at minimum three models including one join model. This means you must have a many-to-many relationship.
3. You should seed your database using data that you collect either from a CSV, a website by scraping, or an API.
4. Your models should have methods that answer interesting questions about the data. For example, if you've collected info about movie reviews, what is the most popular movie? What movie has the most reviews?
5. You should provide a CLI to display the return values of your interesting methods.  
6. Use good OO design patterns. You should have separate classes for your models and CLI interface.

  **Resource:** [Easy Access APIs](https://github.com/learn-co-curriculum/easy-access-apis)

### Option Two - Command Line CRUD App

1. Access a Sqlite3 Database using ActiveRecord.
2. You should have a minimum of three models.
3. You should build out a CLI to give your user full CRUD ability for at least one of your resources. For example, build out a command line To-Do list. A user should be able to create a new to-do, see all todos, update a todo item, and delete a todo. Todos can be grouped into categories, so that a to-do has many categories and categories have many to-dos.
4. Use good OO design patterns. You should have separate models for your runner and CLI interface.

### Brainstorming and Proposing a Project Idea

Projects need to be approved prior to launching into them, so take some time to brainstorm project options that will fulfill the requirements above.  You must have a minimum of four [user stories](https://en.wikipedia.org/wiki/User_story) to help explain how a user will interact with your app.  A user story should follow the general structure of `"As a <role>, I want <goal/desire> so that <benefit>"`. In example, if we were creating an app to randomly choose nearby restaurants on Yelp, we might write:

* As a user, I want to be able to enter my name to retrieve my records
* As a user, I want to enter a location and be given a random nearby restaurant suggestion
* As a user, I should be able to reject a suggestion and not see that restaurant suggestion again
* As a user, I want to be able to save to and retrieve a list of favorite restaurant suggestions

## Instructions

1. Fork and clone this repository.
2. Build your application. Make sure to commit early and commit often. Commit messages should be meaningful (clearly describe what you're doing in the commit) and accurate (there should be nothing in the commit that doesn't match the description in the commit message). Good rule of thumb is to commit every 3-7 mins of actual coding time. Most of your commits should have under 15 lines of code and a 2 line commit is perfectly acceptable.
3. Make sure to create a good README.md with a short description, install instructions, a contributors guide and a link to the license for your code.
4. Make sure your project checks off each of the above requirements.
5. Prepare a video demo (narration helps!) describing how a user would interact with your working project.
    * The video should:
      - Have an overview of your project.(2 minutes max)
6. Prepare a presentation to follow your video.(3 minutes max)
    * Your presentation should:
      - Describe something you struggled to build, and show us how you ultimately implemented it in your code.
      - Discuss 3 things you learned in the process of working on this project.
      - Address, if anything, what you would change or add to what you have today?
      - Present any code you would like to highlight.   
7. *OPTIONAL, BUT RECOMMENDED*: Write a blog post about the project and process.

---
### Common Questions:
- How do I turn off my SQL logger? (so you don't see the process every time you run the program, but you can still debug in the console when required)
```ruby
# in config/environment.rb add this line
# in rakefile is set to Logger.new(STDOUT):
ActiveRecord::Base.logger = false
```
