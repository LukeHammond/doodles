module Interactors
  class ResetPassword
    extend ActiveSupport::Memoizable

    attr_reader :user, :params

    def initialize(user_id, params)
      @user, @params = User.find(user_id), params
    end

    def call
      raise 'invalid token' unless passes_validation?

      user.pass = params[:pass]
      user.pass_confirmation = params[:pass_confirmation]
      user.save
      user.unlock_login

      reset_token(params[:token]).update_attribute(:used_at, Time.now)      
    end

    protected
    def passes_validation?
      params[:token].present? && reset_token(params[:token]).present?
    end

    def reset_token(token)
      user.reset_tokens.find_by_slug(token)
    end
    memoize :reset_token
  end
end