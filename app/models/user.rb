class User < ActiveRecord::Base

  has_secure_password

  has_many :tools
  has_many :sessions
  #
  # def password
  #   @password ||= Password.new(params[:password])
  # end
end
