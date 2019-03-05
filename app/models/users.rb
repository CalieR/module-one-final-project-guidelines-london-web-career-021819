require 'pry'

class Users < ActiveRecord::Base
  has_many :cards, through: :user_cards

  def choose_and_add_card_to_user_deck
    card = choose_hero
    puts "Do you want to add this card to your collection?"
    puts "Enter Y or N only"
    response = gets.chomp
    if response == "Y"
    UserCards.create(user_id: self.id, card_id: card.id)
    end
  end 
end

# binding.pry
0
