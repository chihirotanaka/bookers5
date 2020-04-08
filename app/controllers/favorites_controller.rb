class FavoritesController < ApplicationController
	def create
		book =Book.find(params[:book_id])
		# この表記がわからない
		if current_user.favorites.where(book_id: book.id).empty?
			favorite =current_user.favorites.new(book_id: book.id)
			favorite.save
		end
		# book indexから行った時
		redirect_to request.referrer
	end

	def destroy
		book = Book.find(params[:book_id])
		favorite =current_user.favorites.find_by(book_id: book.id)
		favorite.destroy
		redirect_to request.referrer
	end
end
