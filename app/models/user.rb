class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable

  attachment :profile_image

  has_many :books, dependent: :destroy
  # コメント機能を追加
  has_many :post_comments, dependent: :destroy
  # いいね機能を追加
  has_many :favorites, dependent: :destroy
  # フォロー機能
  has_many :active_relationships, class_name: "Relationship", foreign_key: :follow_id
  has_many :follows, through: :active_relationships, source: :follower
  # フォロワー機能
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :follow
  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, presence: true, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum: 50}

  def followed_by?(user)
    passive_relationships.find_by(follow_id: user.id).present?
  end

end
