Rails.application.routes.draw do

  get 'user/edit'

  get 'user/update'

  #get "wikis/drop_collaborator" => "wikis#drop_collaborator", :as => :drop_collaborator

  resources :wikis

  resources :charges, only: [:new, :create]


  devise_for :users

  get 'about' => 'welcome#about'

  root 'welcome#index'

end
