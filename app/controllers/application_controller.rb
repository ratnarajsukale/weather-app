class ApplicationController < ActionController::Base
    
    def set_current_user
        if session[:user_id]
            Current.user = User.find_by(id: session[:user_id])
        else
            redirect_to sign_up_path
        end
    end

end
