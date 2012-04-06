class User < ActiveRecord::Base
  has_many :reset_tokens
  
  attr_accessor :pass_confirmation

  def unlock_login
    true
  end

end