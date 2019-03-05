class UserCards < ActiveRecord::Base
  belongs_to :users
  belongs_to :cards
end
