require 'pry'

class Users < ActiveRecord::Base
  has_many :cards, through: :user_cards

# TODO work out adding card or not based on input
  def choose_and_add_card_to_user_deck
    prompt = TTY::Prompt.new
    card = choose_hero
    prompt.select('Do you want to add this card to your collection?', %w(Yes No))
    # puts "Do you want to add this card to your collection?"
    # puts "Enter Y or N only"
    # response = gets.chomp
    # if response == "Y"
    #   UserCards.create(user_id: self.id, card_id: card.id)
    # end
    # puts "Do you want to look for another card?"
    # response = gets.chomp
    # if response == "Y"
    #   self.choose_and_add_card_to_user_deck
    # end
  end

  def check_collection
    card_ids = UserCards.select {|card| card["user_id"] == self.id}
    card_ids.each do |card|
      cards = Cards.find_by(id: card["card_id"])
      puts "card number: #{cards["id"]}, name: #{cards["name"]}, intel: #{cards["intelligence"]}"
    end
  end

  def delete_card
    puts "What is the id of the card you want to delete?"
    cid = gets.chomp
    del = UserCards.find_by user_id: self.id, card_id: cid
    del.destroy
    puts "#{(Cards.find_by id: del["card_id"])["name"]} was deleted from your collection!"
  end


end

# binding.pry
0
