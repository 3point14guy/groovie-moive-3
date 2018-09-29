class User < ApplicationRecord
	has_many :user_movies
	has_many :movies, through: :user_movies
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # specifies that the data type for following will be an array.  unable to do this with rails g scaffold or rails g model
  serialize :following, Array
end
