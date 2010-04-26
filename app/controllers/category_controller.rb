class CategoryController < ApplicationController
  before_filter :check_login

  def index
    redirect_to :action => :list
  end

  def list
    @categories = Category.to_options.map do |sname, name|
      cat = Category.find_by_name(name)
      cat.name = sname
      cat
    end
  end

  def save
  end

  def add
    @categories = Category.to_options.map do |sname, name|
      cat = Category.find_by_name(name)
      cat.name = sname
      cat
    end
  end
  
  def edit
  end

  def rm
  end

end
