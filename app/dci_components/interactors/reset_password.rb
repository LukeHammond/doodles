require "#{Rails.root}/app/dci_components/entities/user"

module Interactors
  class ResetPassword

    attr_reader :user, :params

    def initialize(partner_id, user_id, params)
      @partner, @params = Partner.find(partner_id), params

      begin
        user_model = @partner.users.find(user_id)
        @user = Entities::User.new(:user_model => user_model)

      rescue ActiveRecord::RecordNotFound => record_not_found
        @user = Entities::User.new(:user_model => user_model)
        user.errors[:base] << "resource not found"
      end
    end

    def call
      user.errors.add(:token, 'not given') unless params[:token].present?

      if user.valid?
        user.pass = params[:pass]
        user.pass_confirmation = params[:pass_confirmation]
        user.save
        user.unlock_login

        reset_token(params[:token])
      end
      
      user
    end

    protected
    def reset_token(token_slug)
      token = user.reset_tokens.find_by_slug(token_slug)
      if token.present?
        token.update_attribute(:used_at, Time.now)
      else
        user.errors.add(:token, "unable to find reset token for #{token_slug}")
      end
    end
  end
end