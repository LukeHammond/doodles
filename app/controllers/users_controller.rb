require 'active_support'
class UsersController < ApplicationController
  respond_to :json
  
  # curl -X PUT -H "Content-Type: application/json" -d "{\"user\":{\"pass\":\"changeme\",\"token\":\"sluggy\"}}" localhost:3000/users/20174/reset_password.json
  def reset_password
    entity = Interactors::ResetPassword.new(params[:id], params[:user]).call
    json_response = Presenters::ResetPassword.new(entity).call

    respond_with json_response
  end

  # curl -X POST -H "Content-Type: application/json" -d "{\"user\":{\"pass\":\"other\",\"pass_confirmation\":\"other\",\"token\":\"sluggy\",\"first_name\":\"harry\", \"last_name\":\"gibbon\"}}" localhost:3000/users.json
  def create
    entity = Interactors::CreateUser.new(params[:user]).call
    # json_response = Presenters::CreateUser.new(entity).call
    puts entity.inspect
    respond_with entity
  end
  
  # curl -X DELETE -H "Content-Type: application/json" -d "{\"user\":{\"pass\":\"other\",\"pass_confirmation\":\"other\",\"token\":\"sluggy\",\"first_name\":\"harry\", \"last_name\":\"gibbon\"}}" localhost:3000/users/20178.json
  def destroy
    entity = Interactors::DeleteUser.new(params[:id], params[:user]).call
    json_response = Presenters::ResetPassword.new(entity).call

    respond_with json_response    
  end
end