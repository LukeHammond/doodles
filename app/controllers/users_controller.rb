require 'active_support'
class UsersController < ApplicationController
  respond_to :json
  
  # curl -X PUT -H "Content-Type: application/json" -d "{\"user\":{\"pass\":\"changeme\",\"token\":\"sluggy\"}}" localhost:3000/users/20174/reset_password.json
  def reset_password
    entity = Interactors::ResetPassword.new(params[:id], params[:user]).call
    json_response = Presenters::ResetPassword.new(entity).call

    respond_with json_response
  end
end