# README 

add gems to Gemfile

gem 'devise'
gem 'httparty'
gem 'jquery-rails'
gem 'bootstrap', '~> 4.1.3'
gem 'figaro'
gem 'carrierwave', '~> 1.0'
gem 'kaminari'
gem 'font-awesome-rails'
gem 'cancancan'
gem 'hirb'       
gem 'pry-rails'
gem 'better_errors', group: :development
gem 'binding_of_caller'
gem 'geocoder'
gem 'omniauth-github'


change name of assets/stylesheets/application.css to assets/stylesheets/application.scss

add: 

@import "bootstrap";
@import "font-awesome";

in assets/javascripts/application.js

add:

//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets

additionally... 

for Bootstrap:

in views/layouts/application.html.erb

wrap a div with a class name of "container" around <%= yield %>

for devise:

	rails g devise:install
	rails g devise User 
	rails db:migrate
	rails g devise:views

  2. Ensure you have defined root_url to *something* in your config/routes.rb.
     For example:

       root to: "home#index"

You can now go in your app's code and find a model (user.rb), that will look like this:

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
"User" is basic resource name used with Devise. You could use any other name (perhaps "Blogger" in this case), however: there are other gems that work in tandem with Devise, and they require the term "User" to be used.

Our first step in truly requiring authentication to use our app is to put a filter into our application_controller.rb:

class ApplicationController < ActionController::Base
# protects from Cross Site Request Forgery
  protect_from_forgery with: :exception

  # this line below!
  before_action :authenticate_user!
end

for Carrierwave:

	rails g uploader Avatar

This will create an uploader folder (in the app folder), with a file within called avatar_uploader.rb. Inside there, make sure that this line is not commented out:

class AvatarUploader < CarrierWave::Uploader::Base
  storage :file
end
Now we need to add to our User table.

$ rails g migration AddAvatarToUsers avatar:string
$ rails db:migrate
We need to update the sanitizers in application_controller.rb

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :avatar])

    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :avatar])
  end
Then we need to "mount" the uploader on the User model:

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # here it is!
  mount_uploader :avatar, AvatarUploader

  has_many :posts
  has_many :comments
end
Finally, we need to add a configuration in config/application.rb:

config.autoload_paths += %W(#{config.root}/app/uploaders)
(It may work without this step for some people, but was a solution for CW not working for others.)

for kaminari:

Let's paginate our Posts index page. First, we need to tell the Post model how many entries we want on each page.

# post.rb
class Post < ApplicationRecord
  has_many :comments
  belongs_to :user

  paginates_per 3
end
Next, add the page parameter to corresponding ActiveRecord call in posts_controller.rb:

def index
  @posts = Post.all.page(params[:page])
end
Finally, on the view (index.html.erb), at the bottom of the page, call the Paginate helper:

<!-- the rest of the file is up here -->
      </div>
    </div>
  </div>
<% end %>

<%= paginate @posts %>


for Cancancan:

$ rails g cancan:ability
Let's add role to our user and don't forget to add it to the sanitizers in the application_controller.

$ rails g migration AddRoleToUser role:string
$ rails db:migrate
Don't forget to add role to your devise sanitizers (application controller). Remember, without this the role will not be saved.

# application_controller.rb
before_action :configure_permitted_parameters, if: :devise_controller?

def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
   devise_parameter_sanitizer.permit(:account_update, keys: [:role])
end
If the code above gives you an error, try this:

before_action :configure_permitted_parameters, if: :devise_controller?

def configure_permitted_parameters

  devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, 
     :password_confirmation, :role) }

  devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :password, 
     :password_confirmation, :current_password, :role) }
end

for Figaro:

	figaro install
This README would normally document whatever steps are necessary to get the
application up and running.

for Geocoder:

# destination.rb
class Destination < ActiveRecord::Base
  geocoded_by :address
  after_validation :geocode

  def address
    "#{city}, #{country}"
  end
end

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
