Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  root 'books#top'
  get 'home/about' => 'books#about'
  resources :books, only: [:index, :show, :edit, :create, :update, :destroy] do
    resources :books, only: [:destroy]
  end
  
  resources :users, only: [:index, :show, :edit, :update]
  
end