class AdminController < ApplicationController
  
  before_filter :authenticate
  layout "admin"
  def index
    
  end
  private 
    def authenticate
      users = {"admin" =>"superpassword123"}

      realm = "Application"
      authenticate_or_request_with_http_digest(realm) do |name|
        users[name]
      end

    end
end
