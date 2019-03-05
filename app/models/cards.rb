class Cards < ActiveRecord::Base
  has_many :users, through: :user_cards


end
