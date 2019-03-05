require 'pry'

def greet
  puts "Welcome!!"
  puts "Please enter your name:"
end

def create_user
  input = gets.chomp
  puts "Hello #{input}!"
  Users.create(username: input)
end

def choose_hero
  puts "Which superhero would you like to read about?"
  input = gets.chomp
  choice = Cards.find_by(name: input)
  puts choice["name"]
  puts choice["intelligence"]
end

# binding.pry
0
