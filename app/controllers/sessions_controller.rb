class SessionsController < ApplicationController
    def destroy
        session[:user_id] = nil
        redirect_to sign_up_path, notice: "Logged out"
    end
end