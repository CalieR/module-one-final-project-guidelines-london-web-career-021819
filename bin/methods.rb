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

# ask for name, uses Faker to assign a fake superhero name and power
def greeting
  prompt = TTY::Prompt.new
  name = prompt.ask('Please enter your username...(or press ctrl + c to quit program)') do |q|
    q.required true
    q.modify :up, :trim
  end
  search_name = User.find_or_create_by(username: name)
  Whirly.start spinner: "earth" do
    sleep 2
  end
  puts "====================================================================="
  puts "Hello #{name}"
  puts ""
  supername = Faker::Superhero.name.upcase
  superpower = Faker::Superhero.power.upcase
  puts "Today you'll be known as #{supername}..."
  puts "...your super power is #{superpower}!!!"
  puts "====================================================================="
  search_name
end

# uses a TTY prompt to cycle through and handle all of the choices
def menu(search_name)
  prompt = TTY::Prompt.new
  choices = [{name: 'View my cards'},
  {name: 'Add new card to my collection'},
  {name: 'Open mystery pack (get 5 random cards)'},
  {name: 'Delete cards from my collection'},
  {name: 'Collection status'},
  {name: 'View Leaderboard'},
  {name: 'Exit'}]
  answer = prompt.select("What would you like to do?", choices, cycle: true, per_page: 10)
  if answer == 'Add new card to my collection'
    title
    search_name.choose_and_add_card_to_user_deck
    title
    menu(search_name)
  elsif answer == 'Open mystery pack (get 5 random cards)'
    search_name.open_pack
    title
    menu(search_name)
  elsif answer == 'View my cards'
    title
    search_name.check_collection
    puts "Press enter to return to menu"
    input = gets.chomp
    title
    menu(search_name)
  elsif answer == 'Delete cards from my collection'
    title
    search_name.check_collection
    search_name.delete_card
    title
    menu(search_name)
  elsif answer == 'Collection status'
    title
    search_name.cards_left_to_collect
    puts "Press enter to return to menu"
    input = gets.chomp
    title
    menu(search_name)
  elsif answer == "View Leaderboard"
    title
    leaderboard
    title
    menu(search_name)
  elsif answer == 'Exit'
    goodbye
    sleep(3)
    title
    menu(greeting)
  end
end

# uses a TTY prompt to provide scrolling list of characters from Cards table.
# finds the card object matching the users selection,
# passes in that object when it calls display_card_details
def choose_hero
  prompt = TTY::Prompt.new
  names = Card.all.map {|cards| cards["name"]}
  selected_name = prompt.select('Choose a character', names, filter: true, cycle: true, help: "(Start typing to filter results)",help_color: :green, active_color: :yellow, per_page: 20)
  hero = Card.find_by(name: selected_name)
  display_card_details(hero)
  hero
end

# prints out all the attributes from the chosen character's card.
def display_card_details(choice)
  table = TTY::Table.new header:[value: choice["name"].upcase, alignment: :center]
  table << ["INTELLIGENCE: #{choice["intelligence"]}"]
  table << ["STRENGTH: #{choice["strength"]}"]
  table << ["SPEED: #{choice["speed"]}"]
  table << ["DURABILITY: #{choice["durability"]}"]
  table << ["POWER: #{choice["power"]}"]
  table << ["COMBAT: #{choice["combat"]}"]
  puts table.render :unicode, padding: [0,1,0,1]
end

# font from TTY Font, using Pastel to set the colour and style
# menu method calls title and greeting after exit, to reset game ready for next user
def goodbye
  system('clear')
  font = TTY::Font.new(:standard)
  pastel = Pastel.new
  puts "====================================================================="
  puts pastel.yellow.bold(font.write("Goodbye!"))
  puts "====================================================================="
end

# shows the 5 players with the most cards in their collection
def leaderboard
  scores = {}
  User.all.map { |person| scores[person.username] = person.cards.count }
  top5 = scores.sort_by {|k,v| v}.reverse.first(5) # get first however many you want
  # produces an array of arrays like: ['name', num]
  table = TTY::Table.new header:[value: "LEADERBOARD", alignment: :center]
  top5.each do |person|
    table << ["PLAYER: #{person[0]}, SCORE: #{person[1]}"]
  end
  puts table.render :unicode, padding: [0,1,0,1]
  puts "Press enter to return to menu"
  input = gets.chomp
end
