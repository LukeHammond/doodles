module Presenters
  class ResetPassword
 
    attr_accessor :user_entity

    def initialize(user_entity)
      @user_entity = user_entity
    end
    
    def call
      if user_entity.valid?
        {
          :id => user_entity.slug,
          :email => user_entity.email,
          :postal_code => user_entity.postal_code,
          :firstname => user_entity.first_name,
          :lastname => user_entity.last_name,
          :gender => user_entity.gender,
          :birthday => user_entity.birthday,
          :created_at => user_entity.created_at,
          :credits => user_entity.credits || 0,
          # :share_link => user_entity.manual_share.link,
          # :token => user_entity.token,
          :num_purchased => user_entity.num_purchased || 0,
          :total_savings => user_entity.total_savings || 0,
          # :has_passwd => user_entity.has_pass?,
          # :last_login_at => user_entity.data[:last_login_at],
          # :partner_attributes => user_entity.data[:partner_attributes] || {}
        }
      else
        {
          :errors => user_entity.errors.full_messages
        }
      end
      # render :json => json_response, :status => 200 and return
      # ::ActiveSupport::JSON.encode(user_entity.marshal_dump)
    end
  end
end