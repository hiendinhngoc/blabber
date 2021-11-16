Rails.application.routes.draw do

  devise_for :users
  resources :posts, only: %i[index create] do
    get :like
    get :repost
  end

  root to: 'posts#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
