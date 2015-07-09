require 'bcrypt'

class Admin < ActiveRecord::Base
  include BCrypt

  validates :username, presence: true, uniqueness: true, length: { :in => 3..20 }
  attr_accessor :password

  before_create :encrypt_password
  after_save :clear_password

  def authenticate(supplied_password)
    puts supplied_password
    puts encrypted_password
    puts BCrypt::Engine.hash_secret(supplied_password, self.salt)

    self.encrypted_password == BCrypt::Engine.hash_secret(supplied_password, self.salt)

  end

  protected
  def encrypt_password
    self.salt = BCrypt::Engine.generate_salt
    self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
  end

  def clear_password
    @password = nil
  end

end