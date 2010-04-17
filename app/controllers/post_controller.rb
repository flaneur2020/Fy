class PostController < ApplicationController
  before_filter :check_login

  def index
    redirect_to :action => :list
  end

  # TODO: added rescue for find
  def list
    # filters
    cond = {} 
    cond[:category_id] = Category.find_by_name(params[:category]).id  if params[:category]
    cond[:user_id]     = User.    find_by_name(params[:user]).id  if params[:user]
    # by default, do not display the removed
    cond[:state] = ['published', 'draft']
    cond[:state] = params[:state] if params[:state]

    page = params[:page] || 1
    @posts = Post.paginate(:all, 
                           :page=>page,
                           :conditions=>cond, 
                           :order=>'id desc', 
                           :per_page=>15)
  end
  
  # add posts to draft
  def add
    if request.post?
      # blah~
      @post = Post.new(params[:post])
      @post.user = current_user
      @post.category = Category.find(params[:category_id])
      if @post.save
        flash[:notice] = 'posted successfully!'
        redirect_to :action => :edit,
                    :id     => @post.id
      else
        flash[:errors] = @post.errors
      end
    end
  end

  def edit
    @post = Post.find(params[:id])
    if request.post?
      if @post.update_attributes(params[:post])
        flash[:notice] = 'posted successfully!'
        redirect_to :action => :edit,
                    :id     => @post.id
      else 
        flash[:errors] = @post.errors
      end
    end
  rescue ActiveRecord::RecordNotFound => err
    redirect_to_404
  end

  def rm
    @post = Post.find(params[:id])
    @post.state = 'removed'
    if @post.save
      flash[:notice] = "the post '#{@post.title}' have been removed into recycle bin"
      redirect_to params.merge(:action => :list)
    end
  end

  #TODO: rm_many
  def rm_many
    
  end
end
