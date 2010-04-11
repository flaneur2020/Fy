class UserController < ApplicationController
  def login
    if request.post?
      user=params[:user]
      if User.login(user)
        redirect_to :controller => :admin,
                    :action     => :index
      else 
        flash[:error] = 'login failed, please check your name & pass.'
        redirect_to :controller => :user,
                    :action     => :login
      end
    end
  end
  def reg
  end
end
