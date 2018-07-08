Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "restaurants#index"
  resources :restaurants, only: [:index, :show] do
    resources :comments, only: [:create, :destroy]

    
    collection do
      #瀏覽所有餐廳的最新動態
      get :feeds

      #top10 人氣餐廳
      get :ranking
    end

    #瀏覽個別餐廳的dashboard
    member do
      get :dashboard
    end

    #favorite/unfavorite
    member do
      post :favorite
      post :unfavorite
      post :like
      post :unlike
    end


  end
  
  resources :categories, only: :show
  resources :users, only: [:index, :show, :edit, :update]
  resources :followships, only: [:create, :destroy] 

  namespace :admin do
    resources :restaurants
    resources :categories
    root "restaurants#index"
  end
end
