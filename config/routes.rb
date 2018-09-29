Rails.application.routes.draw do
	# directs logged_in user to a diff. view.  from stack overflow answer
	# https://stackoverflow.com/questions/9339514/different-page-for-logged-in-user-and-not-logged-in-user-at-root/19090936#19090936
	# need to come back and look at where this comes from
	authenticated do
		root 'epicenter#logged_in', as: :authenticated
	end
	root 'movies#index'

  get 'logged_in' => 'epicenter#logged_in'
  post 'logged_in' => 'epicenter#logged_in'

  get 'all_users' => 'epicenter#all_users'

  get 'groovie_friends' => 'epicenter#friends'

  get 'add_friend' => 'epicenter#add_friend'
  get 'remove_friend' => 'epicenter#remove_friend'

	
	get 'index' => "movies#index"
	post 'index' => "movies#index"
  resources :movies
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
