module Presenters
  module JsonResponder
    def as_json
      json_response = Presenters::ResetPassword.new(@entity).call
      if @entity.valid?
         render :json => json_response, :status => 200 and return
       elsif @entity.errors[:base].present?
         render :json => json_response, :status => 404 and return
       else 
         render :json => json_response, :status => 422 and return
       end
    end
  end
  class MyResponder < ActionController::Responder
    include JsonResponder
  end
end