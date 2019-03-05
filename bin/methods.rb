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
  Cards.find_by(name: input)
end

def display_card_details
  choice = choose_hero
  puts choice["name"]
  puts choice["intelligence"]
  puts choice["power"]
end

def add_card_to_deck?
  puts "DO you want to add this card to your collection?"
  puts "enter Y or N"
  input = gets.chomp
  if input == "Y"
    # add to collection
    # choose_and_add_card_to_user_deck(card)
  end
  puts "Do you want to see another card?"
  puts "enter Y or N"
  input2 = gets.chomp
  if input2 == "Y"
    choose_hero
  else
    puts "Thanks for playing"
  end
end



# binding.pry
0
