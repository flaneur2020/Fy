class CategoryController < ApplicationController
  before_filter :check_login

  def index
    redirect_to :action => :list
  end

  def list
    page = params[:page] || 1
    @categories = Category.to_options.map do |sname, name|
      cat = Category.find_by_name(name)
      cat.name = sname
      cat
    end
  end

  def add
  end
  
  def edit
  end

  def rm
  end

end
