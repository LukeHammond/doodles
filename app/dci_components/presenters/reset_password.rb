module Presenters
  class ResetPassword
 
    attr_accessor :user

    def initialize(user_entity)
      @user = user_entity
    end
    
    def call
      user.marshal_dump.as_json if user.respond_to?(:marshal_dump)
    end
  end
end