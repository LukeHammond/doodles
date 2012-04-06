module Presenters
  class ResetPassword
 
    attr_accessor :user

    def initialize(user_entity)
      @user = user_entity
    end
    
    def call
      ::ActiveSupport::JSON.encode(user.marshal_dump)
    end
  end
end