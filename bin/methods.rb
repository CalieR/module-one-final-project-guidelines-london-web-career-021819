require_relative '../config/environment'
prompt = TTY::Prompt.new
# def greet
#   puts "Welcome!!"
#   puts "Please enter your name:"
#   input = gets.chomp
#   puts "Hello #{input}!"
#   input
# end

# TODO : split into greeting and menu methods

def menu
  prompt = TTY::Prompt.new
  name = prompt.ask('Please enter your username?')
  search_name = Users.find_or_create_by(username: name)
  puts "Hello #{name}"
  choices = [{name: 'View my collection'},
  {name: 'Add new cards'},
  {name: 'Delete cards from colection'},
  {name: 'Exit'}]
  answer = prompt.select("What would you like to do?", choices)
  if answer == 'Add new cards'
    search_name.choose_and_add_card_to_user_deck
  elsif answer == 'View my collection'
    search_name.check_collection
  elsif answer == 'Delete cards from colection'
    search_name.delete_card
  elsif answer == 'Exit'
    puts "Bye bye!!"
  end
end

def choose_hero
  puts "Which superhero would you like to read about?"
  input = gets.chomp
  choice = Cards.find_by(name: input)
  if !choice
    puts "Character not found"
    choose_hero
  else
    display_card_details(choice)
  end
end

#TODO : Format desired output

def display_card_details(choice)
  puts choice["name"]
  puts choice["intelligence"]
  puts choice["power"]
end
