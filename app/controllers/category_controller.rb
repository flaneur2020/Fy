class CategoryController < ApplicationController
  before_filter :check_login

  def index
    list
  end

  def list
    @category = Category.new
    @categories = Category.as_list
    render :action => :list
  end

  def new
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

  # TODO
  def destroy
    redirect_to :action=>:list
  end

  # params[:name]
  def search
    @category = Category.find_by_name(params[:name])
    if @category
      redirect_to category_url(:edit, @category.id)
    else
      flash[:notice] = 'did not find this category '
      redirect_to category_url(:list)
    end
  end

end
