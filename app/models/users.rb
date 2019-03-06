require 'pry'

class Users < ActiveRecord::Base
  has_many :cards, through: :user_cards

  def choose_and_add_card_to_user_deck
    prompt = TTY::Prompt.new
    card = choose_hero
    response = prompt.select('Do you want to add this card to your collection?', %w(Yes No))
    if response == "Yes"
      UserCards.create(user_id: self.id, card_id: card.id)
    end
    response = prompt.select('Do you want to look for another card?', %w(Yes No))
    if response == "Yes"
      self.choose_and_add_card_to_user_deck
    end
  end

  def check_collection
    card_ids = UserCards.select {|card| card["user_id"] == self.id}
      if card_ids == []
        puts "Your collection is empty"
      else
        puts "-----------------------------------------------------------------------------------"
        puts "----- YOU HAVE #{card_ids.length} CARD(S) IN YOUR COLLECTION ---------------------------------------"
        puts "-----------------------------------------------------------------------------------"
        card_ids.each do |card|
          cards = Cards.find_by(id: card["card_id"])
          puts "|No: #{cards["id"]}|Name: #{cards["name"].upcase}   |INT: #{cards["intelligence"]}|STR: #{cards["strength"]}|SPE: #{cards["speed"]}|DUR: #{cards["durability"]}|POW: #{cards["power"]}|COM: #{cards["combat"]}"
        end
        puts "-----------------------------------------------------------------------------------"
      end
  end

  def delete_card
    puts "What is the id of the card you want to delete?"
    cid = gets.chomp
    del = UserCards.find_by user_id: self.id, card_id: cid
    del.destroy
    puts "#{(Cards.find_by id: del["card_id"])["name"].upcase} was deleted from your collection!"
  end


end

# binding.pry
0
