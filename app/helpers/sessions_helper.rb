module SessionsHelper

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.digest(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def sign_out
    current_user.update_attribute(:remember_token,
                                  User.digest(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end
end



# module SessionsHelper

#   def sign_in(user)
#     remember_token = User.new_remember_token
#     cookies.permanent[:remember_token] = remember_token
#     user.update_attribute(:remember_token, User.digest(remember_token))
#     self.current_user = user
#   end
#   # Logs in the given user.
#   def log_in(user)
#     session[:user_id] = user.id
#   end

#   # Returns the current logged-in user (if any).
#   def current_user
#     @current_user ||= User.find_by(id: session[:user_id])
#   end

#   # Returns true if the user is logged in, false otherwise.
#   def logged_in?
#     !current_user.nil?
#   end
# end

