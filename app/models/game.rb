class Game < ApplicationRecord

	# for extra security we'll reference each game by its uuid
	# instead of a sequencial id
	before_create :add_uuid

	 private
	   def add_uuid
	     self.uuid = SecureRandom.uuid
	   end

end
