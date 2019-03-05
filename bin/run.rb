require_relative '../config/environment'
require_relative './methods.rb'
require_all 'app'

greet
user = create_user
user.choose_and_add_card_to_user_deck


# puts "HELLO WORLD"
