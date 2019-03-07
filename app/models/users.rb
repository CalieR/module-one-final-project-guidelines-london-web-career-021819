require 'pry'

class User < ActiveRecord::Base
  has_many :user_cards
  has_many :cards, through: :user_cards


  # calls 'choose_hero' to display all the cards to the user, and assigns their choice to 'card'
  # TTY prompt for the yes/no menu
  # if 'yes', creates a new row in the card table for that specific user_id, assigning them that card_id
  # asks if user wants to select another card, if they do it calls on itself to offer the choices again (and so on)
  def choose_and_add_card_to_user_deck
    prompt = TTY::Prompt.new
    card = choose_hero
    response = prompt.select('Do you want to add this card to your collection?', %w(Yes No))
    if response == "Yes"
      added_card = UserCard.create(user_id: self.id, card_id: card.id)
      puts "#{added_card.card.name.upcase} was added to your collection."
      sleep(1)
    end
    system('clear')
    title
    response = prompt.select('Do you want to look for another card?', %w(Yes No))
    if response == "Yes"
      self.choose_and_add_card_to_user_deck
    end
  end

  # gets all the users cards and displays them in number order
  # also displays count message, depending on whether they have some or none
  # had to use 'reload' because rails was using cached array, had to force to go back to db and refresh the card for the user.
  def check_collection
    system('clear')
    title
    your_cards = self.reload.cards.sort
      if your_cards == []
        puts "====================================================================="
        puts "Your collection is empty"
        puts "====================================================================="
      else
        puts "====================================================================="
        puts "----- YOU HAVE #{your_cards.length} CARD(S) IN YOUR COLLECTION ------"
        puts "====================================================================="
        your_cards.each do |card|
          puts "|NUMBER: #{card["id"]}   |NAME: #{card["name"].upcase}   |INTELLIGENCE: #{card["intelligence"]}   |STRENGTH: #{card["strength"]}   |SPEED: #{card["speed"]}   |DURABILITY: #{card["durability"]}   |POWER: #{card["power"]}   |COMBAT: #{card["combat"]}"
        end
        puts "====================================================================="
      end
  end

  # iterates over all the cards for that user, passes resulting array of names to TTY prompt to display choices.
  # choice from the list of names is stored in selected_card_name
  # the card object for that choice is stored in selected_card
  # the UserCard object from that specific user's collection is stored in choice
  # choice is destroyed if the user chooses yes, confirmation message displayed.
  # if user decides not to delete, check_collection is called to return to users card list
  def delete_card
    prompt = TTY::Prompt.new
    your_cards = self.cards
    card_names  = your_cards.map { |card| card["name"] }
    selected_card_name = prompt.select('Choose a character to delete', card_names, filter: true, cycle: true, help: "(Start typing to filter results)", help_color: :green, active_color: :yellow)
    selected_card = Card.find_by(name: selected_card_name)
    choice = UserCard.find_by user_id: self.id, card_id: selected_card.id
    response = prompt.select("Are you sure you want to delete #{selected_card_name.upcase}?", %w(Yes No))
    if response == "Yes"
      choice.destroy
      bar = TTY::ProgressBar.new("Deleting #{selected_card_name.upcase} [:bar]", total: 30)
      30.times do
        sleep(0.05)
        bar.advance(1)
      end
      puts "#{choice.card.name.upcase} was deleted from your collection!"
      sleep(1)
      system('clear')
      title
    else
      check_collection
    end
  end

  # finds the users cards, removes any duplicates and subtracts that number from total cards (160)
  # Displays message showing how many cards user still needs to complete colletion.
  def cards_left_to_collect
    card_ids = UserCard.select {|card| card["user_id"] == self.id}
    remaining = Card.all.count - card_ids.map { |card| card["card_id"] }.uniq.count
    if remaining == 0
      puts "====================================================================="
      puts "Congratulations, you have completed the Superhero card album!!"
      puts "====================================================================="
    else
      puts "====================================================================="
      puts "You still have #{remaining} cards left to collect..."
      puts "====================================================================="
    end
  end

end # end of class

# binding.pry
0
