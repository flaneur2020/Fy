# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '2f8d42c468821c1b5e8edbeadc9c6450'

  protected

  def current_user
    User.find(session[:user_id])
  end

  def check_login
    if session[:user_id]
      @current_user = current_user
    else
      flash[:from]   = request.path
      flash[:notice] = 'please login first'
      redirect_to :controller => :user,
                  :action     => :login
    end
  end

  def redirect_to_404
    redirect_to :controller => :admin,
                :action     => 'orz_404'
  end

end
