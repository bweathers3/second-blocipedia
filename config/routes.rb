Rails.application.routes.draw do

  get 'user/edit'

  get 'user/update'

  resources :wikis

  resources :charges, only: [:new, :create]

  #resources :user, only: [:edit, :update]

  devise_for :users

  get 'about' => 'welcome#about'

  root 'welcome#index'

end
