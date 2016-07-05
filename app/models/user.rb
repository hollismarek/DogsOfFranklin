class User < ApplicationRecord
  has_secure_password

  #validates_uniqueness_of :username, :email
  #validates_presence_of :username, :first_name, :last_name, :email, :password
end
