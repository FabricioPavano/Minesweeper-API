class AddStateToGame < ActiveRecord::Migration[6.0]
  
	# Saving State in a different table using Box records
	# Makes it too slow when the MineSweeper game has hundreds of boxes
	# So I'm trying to serialize a hash with the game state and save it in a text column
  def change
  	change_table :games do |t|
  	  t.text :state
  	end
  end
end
