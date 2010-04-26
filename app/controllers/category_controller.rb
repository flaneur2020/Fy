class CategoryController < ApplicationController
  before_filter :check_login

  def index
    redirect_to :action => :list
  end

  def list
    @category = Category.new
    @categories = Category.as_list
  end

  def add
    @category = Category.new
    @category.parent = Category.find(params[:parent_id]) if params[:parent_id]
    render :action => :edit
  end
  
  def edit
    @category = Category.find(params[:id])
    render :action => :edit
  end

  def save
    @category = Category.find_or_new(params[:id])
    if request.post?
      @category.attributes = params[:category]
      @category.parent = Category.find_by_name(params[:parent_name])
      if @category.save
        flash[:notice] = 'category saved successfully'
        redirect_to :action=>:list
      else
        flash[:errors] = @category.errors
        render :action => :edit
      end
    end
  end

  def rm
  end

end
