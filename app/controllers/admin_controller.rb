class AdminController < ApplicationController
  before_filter :check_login, :except=>:orz_404

  def index
  end

end
