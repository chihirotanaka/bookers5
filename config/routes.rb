Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:show,:index,:edit,:update] do
    resource :relationships, only:[:create, :destroy]
#  フォロー/フォロワー機能
    get :follows, on: :member
    get :followers, on: :member
  end

  #  コメントいいねをネストさせる
  resources :books do
  	resource :favorites, only:[:create, :destroy]
  	resource :post_comments, only:[:create, :destroy]
end
  root 'home#top'
  get 'home/about' => 'home#about'
end
