class CreateCardsTable < ActiveRecord::Migration[4.2]
  def change
    create_table :cards do |t|
      t.string :name
      t.integer :intelligence
      t.integer :strength
      t.integer :speed
      t.integer :durability
      t.integer :power
      t.integer :combat
    end
  end
end
