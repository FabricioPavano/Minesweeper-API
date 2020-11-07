class Box < ApplicationRecord
	enum status: [ :covered, :uncovered, :flagged, :marked ]
end
