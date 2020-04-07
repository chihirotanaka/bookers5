class PostComment < ApplicationRecord
	# userとbookを結びつける
	belongs_to :user
	belongs_to :book
end
