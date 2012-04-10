module Entities
  class User
    include ActiveModel::Validations

    attr_reader :user_model
    
    attr_accessor :pass_confirmation

    validates_presence_of :email

    delegate :first_name, :first_name=, :last_name, :last_name=, :email, :email=, 
             :pass, :pass=, :unlock_login, :reset_tokens,
             :gender, :gender=, :birthday, :birthday=, :created_at, :credits,
             :manual_share, :token, :num_purchased, :total_savings, :manual_share,
             :postal_code, :postal_code=, :slug, :slug=, :has_pass?, :data, :to => :user_model
    
    def initialize(attr_hash)
      @user_model = attr_hash[:user_model]
    end
    
    def save
      user_model.save
    end

    def valid?(context = nil)
      errors.empty?
    end
  end
end