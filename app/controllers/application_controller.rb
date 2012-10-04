class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :logged_in?
  
    # Returns true or false if the user is logged in.
    # Preloads @current_user with the user model if they're logged in.
    def logged_in?
      current_user
    end

    # Accesses the current user from the session.
    # Future calls avoid the database because nil is not equal to false.
    def current_user
      @current_user ||= (login_from_session) unless @current_user == false
    end

    # Store the given user id in the session.
    def current_user=(new_user)
      session[:user_id] = new_user ? new_user.id : nil
      @current_user = new_user || false
    end

    def login_required
      logged_in? || access_denied
    end

    def access_denied
      respond_to do |format|
        format.html do
          redirect_to login_path
        end
      end
    end
    def login_from_session
      if session[:user_id]
        u = User.find_by_id(session[:user_id])
        self.current_user = u 
      end
    end

end
