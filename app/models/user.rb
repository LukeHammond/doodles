class User < ActiveRecord::Base
  has_many :reset_tokens
  
  def reset_password(params)
    raise 'invalid token' if !params[:token].present? || !(token = ResetToken.find_by_slug(params[:token])) || (id != token.user_id)

    pass = params[:pass]
    pass_confirmation = params[:pass_confirmation]
    save
    unlock_login
    token.update_attribute(:used_at, Time.now)
  end
  
  def unlock_login
    true
  end
end