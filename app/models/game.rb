class Game < ApplicationRecord

	# Associations
	has_many :boxes, :dependent => :destroy


	# Hooks

	# for extra security we'll reference each game by its uuid
	# instead of a sequencial id
	before_create :add_uuid
	after_create :create_boxes

  private
	  def add_uuid
	    self.uuid = SecureRandom.uuid
	  end

	  def create_boxes

			# An array with numbers 1, 2 ... n being n the number of rows
			rows_array = (1..self.rows).to_a

			# An array with numbers 1, 2 ... m being m the number of columns
			columns_array = (1..self.cols).to_a

			# Multiplying the arrays we get all the boxes positions
			all_positions = rows_array.product(columns_array)

			# Maps each array with positions to a hash
			# Initially there are no boxes with mines
			box_objects = all_positions.map do |position|
				{
					row: position[0],
					col: position[1],
					status: :covered,
					has_mine: false
				}
			end

			# Takes the indicated amount of random boxes and adds mines to them
			box_objects.sample(self.mines).map! do |box_object|
				box_object[:has_mine] = true
				box_object
			end

			self.boxes.create(box_objects)

		end

end
