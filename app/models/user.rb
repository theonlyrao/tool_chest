class User < ActiveRecord::Base

  has_secure_password

  has_many :tools
  has_many :sessions
  has_many :categories, through: :tools
  #
  # def password
  #   @password ||= Password.new(params[:password])
  # end
end
