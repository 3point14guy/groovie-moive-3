Rails.application.routes.draw do
	root 'movies#index'
	get 'index' => "movies#index"
	post 'index' => "movies#index"
  resources :movies
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
