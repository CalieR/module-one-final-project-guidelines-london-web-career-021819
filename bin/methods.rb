require_relative '../config/environment'
require 'pry'


def title
  font = TTY::Font.new(:standard)
  pastel = Pastel.new
  puts "====================================================================="
  puts pastel.yellow.bold(font.write("Superhero"))
  puts pastel.yellow.bold(font.write("Card"))
  puts pastel.yellow.bold(font.write("Collection"))
  puts "====================================================================="
end


def greeting
  prompt = TTY::Prompt.new
  name = prompt.ask('Please enter your username?') { |q| q.modify :up }
  search_name = Users.find_or_create_by(username: name)
  puts "Hello #{name}"
  supername = Faker::Superhero.name.upcase
  superpower = Faker::Superhero.power.upcase
  puts "Today you'll be known as #{supername}..."
  puts "...your super power is #{superpower}!!!"
  search_name
end

def menu(search_name)
  prompt = TTY::Prompt.new
  choices = [{name: 'View my collection'},
  {name: 'Add new cards'},
  {name: 'Delete cards from colection'},
  {name: 'Exit'}]
  answer = prompt.select("What would you like to do?", choices, cycle: true)
  if answer == 'Add new cards'
    search_name.choose_and_add_card_to_user_deck
    menu(search_name)
  elsif answer == 'View my collection'
    search_name.check_collection
    menu(search_name)
  elsif answer == 'Delete cards from colection'
    search_name.delete_card
    menu(search_name)
  elsif answer == 'Exit'
    puts "Bye bye!!"
  end
end


# def choose_hero
#   puts "Which superhero would you like to read about?"
#   input = gets.chomp
#   binding.pry
#   choice = Cards.find_by(name: input)
#   if !choice
#     puts "Character not found"
#     choose_hero
#   else
#     display_card_details(choice)
#   end
# end

def choose_hero
  prompt = TTY::Prompt.new
  names = Cards.all.map {|cards| cards["name"]}
  selected_name = prompt.select('Choose a character', names, filter: true, cycle: true, help: "(Start typing to filter results)",help_color: :green, active_color: :yellow)
  hero = Cards.find_by(name: selected_name)
  display_card_details(hero)
  hero
end

#TODO : Format desired output

def display_card_details(choice)
  puts "====================="
  puts "|  #{choice["name"].upcase}"
  puts "====================="
  puts "| INTELLIGENCE:.. #{choice["intelligence"]}"
  puts "| STRENGTH:...... #{choice["strength"]}"
  puts "| SPEED:......... #{choice["speed"]}"
  puts "| DURABILITY:.... #{choice["durability"]}"
  puts "| POWER:......... #{choice["power"]}"
  puts "| COMBAT:........ #{choice["combat"]}"
  puts "====================="
end
