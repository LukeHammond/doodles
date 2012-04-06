class User < ActiveRecord::Base
  extend ActiveSupport::Memoizable

  has_many :reset_tokens
  
  def reset_password(params)
    raise 'invalid token' unless passes_validation?(params)

    pass = params[:pass]
    pass_confirmation = params[:pass_confirmation]
    save
    unlock_login
    reset_token(params[:token]).update_attribute(:used_at, Time.now)
  end
  
  def unlock_login
    true
  end

  def passes_validation?(params)
    params[:token].present? && reset_token(params[:token]).present?
  end

  def reset_token(token)
    self.reset_tokens.find_by_slug(token)
  end
  memoize :reset_token
end