Rails.application.routes.draw do

  #get 'users/show'
  get 'posts/index' =>'posts#index'
  get 'posts/new' => 'posts#new'
  post 'posts/create' => 'posts#create'
  get 'posts/:id' => 'posts#show'
  get 'posts/:id/edit' => 'posts#edit'
  post 'posts/:id/update' =>'posts#update'
  post 'posts/:id/destroy' =>'posts#destroy'

  post 'likes/:id/create' => 'likes#create'
  post 'likes/:id/destroy' => 'likes#destroy'

  get '/' => 'home#top'
  devise_for :users
  
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  get 'users/:id' => 'users#show'
  get 'users/:id/likes' => 'users#likes'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
