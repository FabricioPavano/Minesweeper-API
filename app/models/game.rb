class Game < ApplicationRecord

	# Associations
	has_many :boxes, :dependent => :destroy


	# Hooks

	# for extra security we'll reference each game by its uuid
	# instead of a sequencial id
	before_create :add_uuid
	after_create :create_boxes

	def state
		YAML.load(self[:state]) if self[:state].present?
	end

	def find_box

	end


  private
	  def add_uuid
	    self.uuid = SecureRandom.uuid
	  end

	  def create_boxes

			# An array with numbers 1, 2 ... n being n the number of rows
			rows_array = (1..self.rows).to_a

			# An array with numbers 1, 2 ... m being m the number of columns
			columns_array = (1..self.cols).to_a

			# we create a lookup hash to find number adjacent mines faster
			lookup_hash = {}

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
				# We only save in this hash the positions where mines exist
				lookup_hash[box_object[:row].to_s + ':' + box_object[:col].to_s] = true

				box_object[:has_mine] = true
				box_object
			end

			# This array contains how many rows and columns should we move left or right
			# in order to find all 8 adjacent boxes
			deltas_array = [[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]]

			# pre-computes adjacent mines
			box_objects.map do |box_object|
				# If it has a mine it we just return nil
				if box_object[:has_mine]
					box_object[:adjacent] = nil
					next box_object
				end

				current_row = box_object[:row]
				current_col = box_object[:col]

				adjacent_mines = deltas_array.inject(0) do |number_of_mines, deltas|

					row_delta = deltas[0]
					col_delta = deltas[1]

					row_to_check = current_row + row_delta
					col_to_check = current_col + col_delta

					if lookup_hash[row_to_check.to_s + ':' + col_to_check.to_s]
						number_of_mines += 1
					else
						number_of_mines
					end
				end

				box_object[:adjacent] = adjacent_mines
				box_object
			end

			# Serialize initial state

			serialized_state = YAML.dump(box_objects)

			self.update_column(:state, serialized_state)

		end

end
