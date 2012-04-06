require 'ostruct.rb'

module Interactors
  class DeleteUser
    extend ActiveSupport::Memoizable

    attr_reader :user, :params

    ATTRIBUTES = %w(email postal_code source first_name last_name pass pass_confirmation slug )

    def initialize(user_id, params)
      @user, @params = User.find(user_id), params
    end

    def call
      # switch off for the moment
      # raise 'unable to delete' unless passes_validation?
      user.destroy

      ::OpenStruct.new(attr_hash)
    end
    
    protected
    def passes_validation?
      attr_hash == filted_attributes(user.attributes)
    end
    
    def attr_hash
      attr_hash = {}.merge filted_attributes(params)
    end
    memoize :attr_hash

    def filted_attributes(hash)
      hash.select { |k, v| ATTRIBUTES.include? k }
    end
    
  end
end