require 'ostruct.rb'

module Interactors
  class CreateUser
    extend ActiveSupport::Memoizable

    attr_reader :user, :params

    ATTRIBUTES = %w(email postal_code source first_name last_name pass pass_confirmation slug )

    def initialize(params)
      @params = params
    end

    def call
      attr_hash = {}.merge params.select { |k, v| ATTRIBUTES.include? k }
      attr_hash[:slug] ||= attr_hash['first_name'] + attr_hash['last_name']
      
      User.create(attr_hash)

      ::OpenStruct.new(attr_hash)
    end
  end
end