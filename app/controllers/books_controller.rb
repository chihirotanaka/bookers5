class BooksController < ApplicationController
# 投稿本の一覧
  def show
    @user = User.all
  	@book = Book.find(params[:id])
    @books = Book.all
    @booknew = Book.new
  end
# 本の共有ページ
  def index
  	@books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall
    @book = Book.new
  end
# 本の感想作成
  def create
  	@book = Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
    @book.user_id = current_user.id
 if @book.save #入力されたデータをdbに保存する。
  	redirect_to book_path(@book.id), notice: "successfully created book!"#保存された場合の移動先を指定。
  	else
  		@books = Book.all
  		render 'index'
  	end
  end
# 本の編集
  def edit
  	@book = Book.find(params[:id])
 if @book.user_id != current_user.id
    redirect_to books_path
  end
end


# 本の感想編集
  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to book_path(@book.id), notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render :edit
  	end
  end
# 本の削除
  def destroy
  	@book = Book.find(params[:id])
  	@book.destroy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
  	params.require(:book).permit(:title, :body)
  end

end
