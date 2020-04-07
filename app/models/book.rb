class Book < ApplicationRecord
	#バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
	#presence trueは空欄の場合を意味する。
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
	belongs_to :user
	# コメント機能をアソシエーション
	has_many :post_comments, dependent: :destroy
	# いいね機能をアソシエーション
	has_many :favorites, dependent: :destroy

# いいね昨日のためにこの一文を追加
	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end
end
