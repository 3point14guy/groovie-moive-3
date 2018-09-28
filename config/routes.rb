Rails.application.routes.draw do
	authenticated do
		root 'epicenter#logged_in', as: :authenticated
	end
	root 'movies#index'
  get 'logged_in' => 'epicenter#logged_in'
  post 'logged_in' => 'epicenter#logged_in'

  get 'epicenter/all_users'

  get 'epicenter/friends'

	
	get 'index' => "movies#index"
	post 'index' => "movies#index"
  resources :movies
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
