module SessionsHelper
  
  # log-in by creating session
  def log_in(user)
    session[:user_id] = user.id	
  end

  # log-out
  def log_out
    @current_user = nil
    session.delete(:user_id)
    session.delete(:warning) if session[:warning]
    session.delete(:reminder) if session[:reminder]
  end
    
  # current user instance variable
  def current_user 
    @current_user ||= User.find_by(id: session[:user_id], disabled: false)
  end

  # user logged in ot not?
  def logged_in?
    !current_user.nil?
  end  

  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

end
