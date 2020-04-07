class Favorite < ApplicationRecord
	# userとbookを結びつける(sに注意)
	belongs_to :user
	belongs_to :book
end
