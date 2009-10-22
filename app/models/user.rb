class User < ActiveRecord::Base
  attr_accessor :pasword_confirmation
  attr_reader :password
  
  validates_uniqueness_of :email
  validates_presence_of :password
  validates_confirmation_of :password
  validates_format_of :email,
                      :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
                      
  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = User.encrypted_password(pwd, self.salt)
    end
    #Returns user if the supplied email and password match the database record
    def User.authenticate(email, password)
      user = User.find_by_email(email)
      if user
        password_attempt = User.encrypted_password(password, user.salt)
        if password_attempt != user.hashed_password
          user=nil
          end 
      end
      return user
    end
    
    private
    #generates some random value to store in the database
    def create_new_salt
      self.salt = Digest::SHA256.hexdigest(Time.now.to_s + rand.to_s)
    end
    #Given a password and a generated salt
    #Returns the hashed password
    def User.encrypted_password(pwd, salt)
       string_to_hash = pwd +salt
       Digest::SHA256.hexdigest(string_to_hash)
      end
end
