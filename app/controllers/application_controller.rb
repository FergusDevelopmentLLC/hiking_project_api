class ApplicationController < ActionController::API
    def welcome
      render json: "Welcome  to the Hiking Project API"
    end
end
