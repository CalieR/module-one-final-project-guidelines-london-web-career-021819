require_relative '../config/environment'
require 'pry'


def title
  system('clear')
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
  name = prompt.ask('Please enter your username...(or press ctrl + c to quit program)') do |q|
    q.required true
    q.modify :up, :trim
  end
  search_name = User.find_or_create_by(username: name)
  Whirly.start spinner: "earth" do
    sleep 3
  end
  puts "__________________________________________"
  puts "Hello #{name}"
  puts ""
  supername = Faker::Superhero.name.upcase
  superpower = Faker::Superhero.power.upcase
  puts "Today you'll be known as #{supername}..."
  puts "...your super power is #{superpower}!!!"
  puts "__________________________________________"
  search_name
end

def menu(search_name)
  prompt = TTY::Prompt.new
  choices = [{name: 'View my cards'},
  {name: 'Add new cards to my collection'},
  {name: 'Delete cards from my collection'},
  {name: 'Collection status'},
  {name: 'Exit'}]
  answer = prompt.select("What would you like to do?", choices, cycle: true)
  if answer == 'Add new cards to my collection'
    system('clear')
    title
    search_name.choose_and_add_card_to_user_deck
    menu(search_name)
  elsif answer == 'View my cards'
    system('clear')
    title
    search_name.check_collection
    menu(search_name)
  elsif answer == 'Delete cards from my collection'
    system('clear')
    title
    search_name.check_collection
    search_name.delete_card
    menu(search_name)
  elsif answer == 'Collection status'
    system('clear')
    title
    search_name.cards_left_to_collect
    menu(search_name)
  elsif answer == 'Exit'
    goodbye
    sleep(3)
    title
    menu(greeting)
  end
end

def choose_hero
  prompt = TTY::Prompt.new
  names = Card.all.map {|cards| cards["name"]}
  selected_name = prompt.select('Choose a character', names, filter: true, cycle: true, help: "(Start typing to filter results)",help_color: :green, active_color: :yellow)
  hero = Card.find_by(name: selected_name)
  display_card_details(hero)
  hero
end

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

def goodbye
  system('clear')
  font = TTY::Font.new(:standard)
  pastel = Pastel.new
  puts "====================================================================="
  puts pastel.yellow.bold(font.write("Goodbye!"))
  puts "====================================================================="
end
