require 'active_support'
require "#{Rails.root}/app/dci_components/presenters/json_responder"
class UsersController < ApplicationController
  respond_to :json
  
  # curl -X PUT -H "Content-Type: application/json" -d "{\"user\":{\"pass\":\"changeme\",\"token\":\"sluggy\"}}" localhost:3000/partners/21/users/20174/reset_password.json
  def reset_password
    entity = Interactors::ResetPassword.new(params[:partner_id], params[:id], params[:user]).call
    json_response = Presenters::ResetPassword.new(entity).call

    if entity.valid?
      render :json => json_response, :status => 200 and return
    elsif entity.errors[:base].present?
      render :json => json_response, :status => 404 and return
    else
      render :json => json_response, :status => 422 and return
    end
    # respond_with @entity
  end

  # curl -X POST -H "Content-Type: application/json" -d "{\"user\":{\"pass\":\"other\",\"pass_confirmation\":\"other\",\"token\":\"sluggy\",\"first_name\":\"harry\", \"last_name\":\"gibbon\"}}" localhost:3000/users.json
  def create
    entity = Interactors::CreateUser.new(params[:user]).call
    json_response = Presenters::CreateUser.new(entity).call

    render :json => json_response, :status => 201 and return
    # respond_with entity
  end
  
  # curl -X DELETE -H "Content-Type: application/json" -d "{\"user\":{\"pass\":\"other\",\"pass_confirmation\":\"other\",\"token\":\"sluggy\",\"first_name\":\"harry\", \"last_name\":\"gibbon\"}}" localhost:3000/users/20178.json
  def destroy
    entity = Interactors::DeleteUser.new(params[:id], params[:user]).call
    json_response = Presenters::ResetPassword.new(entity).call

    render :json => json_response, :status => 200 and return
    # respond_with json_response
  end
  
  # curl -X GET -H "Content-Type: application/json" localhost:3000/users/20174/authenticate.json
  def authenticate
    entity = Interactors::Authenticate.new(params[:id], params[:user]).call
    json_response = Presenters::Authenticate.new(entity).call

    render :json => json_response, :status => 200 and return
  end
  
  def self.responder
    Presenters::MyResponder
  end
  protected
  
  def responder
    Presenters::MyResponder
  end
end