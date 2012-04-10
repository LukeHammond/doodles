require 'ostruct.rb'

module Interactors
  class Authenticate
    extend ActiveSupport::Memoizable

    attr_reader :user, :params

    def initialize(user_id, params)
      @user, @params = User.find(user_id), params
    end

    def call
      user = User.find_by_email_address params[:email]
      if user.nil?
        LoginActivity.create_with info.merge(extra_login_activity_info(email))
        raise ActiveResource::ResourceNotFound.new(:user)
      end
      begin
        result = user.authenticate password,
          info.merge(extra_login_activity_info(email))
      rescue User::LockedLoginError
        raise_login_error({:email => ["has been locked"]})
      end
      raise_login_error({:pass => ["invalid password"]}) unless result
      
      
      ::OpenStruct.new(:slug => user.slug)
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