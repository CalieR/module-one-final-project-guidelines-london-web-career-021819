require 'pry'

class User < ActiveRecord::Base
  has_many :user_cards
  has_many :cards, through: :user_cards

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

  def check_collection
    system('clear')
    title
    your_cards = self.reload.cards.sort
      if your_cards == []
        puts "-----------------------------------------------------------------------------------"
        puts "Your collection is empty"
        puts "-----------------------------------------------------------------------------------"
      else
        puts "-----------------------------------------------------------------------------------"
        puts "----- YOU HAVE #{your_cards.length} CARD(S) IN YOUR COLLECTION --------------------"
        puts "-----------------------------------------------------------------------------------"
        # had to add reload because rails was using cached array, had to force to go back to db.
        # but doesn't refresh card count
        your_cards.each do |card|
          puts "|No: #{card["id"]}|Name: #{card["name"].upcase}   |INT: #{card["intelligence"]}|STR: #{card["strength"]}|SPE: #{card["speed"]}|DUR: #{card["durability"]}|POW: #{card["power"]}|COM: #{card["combat"]}"
        end
        puts "-----------------------------------------------------------------------------------"
      end
  end


  def delete_card
    prompt = TTY::Prompt.new
    your_cards = self.cards
    card_names  = your_cards.map { |card| card["name"] }
    # selected_card_name is the choice from the list
    selected_card_name = prompt.select('Choose a character to delete', card_names, filter: true, cycle: true, help: "(Start typing to filter results)", help_color: :green, active_color: :yellow)
    # selected card is the object for the name the user chose
    selected_card = Card.find_by(name: selected_card_name)
    # choice is the card object from that user's collection
    choice = UserCard.find_by user_id: self.id, card_id: selected_card.id
    response = prompt.select("Are you sure you want to delete #{selected_card_name.upcase}?", %w(Yes No))
    if response == "Yes"
      choice.destroy
      # not destroyig!!
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

  def cards_left_to_collect
    card_ids = UserCard.select {|card| card["user_id"] == self.id}
    remaining = Card.all.count - card_ids.map { |card| card["card_id"] }.uniq.count
    if remaining == 0
      puts "------------------------------------------------------------------"
      puts "Congratulations, you have completed the Superhero card album!!"
      puts "------------------------------------------------------------------"
    else
      puts "------------------------------------------------------------------"
      puts "You still have #{remaining} cards left to collect..."
      puts "------------------------------------------------------------------"
    end
  end

end # end of class

# binding.pry
0
