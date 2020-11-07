class CreateBoxes < ActiveRecord::Migration[6.0]
  def change
    create_table :boxes do |t|
    	t.bigint  :game_id
    	t.integer :row
    	t.integer :col
    	t.boolean :has_mine
    	t.integer :status
      t.timestamps
    end
  end
end
