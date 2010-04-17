class UserController < ApplicationController
  before_filter :check_login, :except => :login

  def login
    session[:user_id] = nil
    if request.post?
      name = params[:user][:name]
      pass = params[:user][:pass]
      user = User.login(name, pass)
      if user
        session[:user_id] = user.id
        # people may login from everywhere. let him go back
        redirect_to(params[:from] || {
          :controller => :admin,
          :action     => :index
        })
      else 
        # login failed
        raise 'login failed'
      end
    end
  rescue
    flash[:notice] = 'login failed, please check your name & pass.'
    redirect_to :action => :login
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "you've logout successfully" 
    redirect_to :action => :login
  end

  def reg
  end

end
