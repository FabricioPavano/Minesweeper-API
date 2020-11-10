class AddFlagsInfoToGame < ActiveRecord::Migration[6.0]
  def change
  	change_table :games do |t|
  	  t.integer :mines_flagged, :default => 0
  	  t.integer :used_flags, :default => 0
  	end
  end
end
